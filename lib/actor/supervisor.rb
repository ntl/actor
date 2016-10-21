module Actor
  class Supervisor
    include Actor

    attr_reader :assembly
    attr_writer :broadcast_address
    attr_accessor :error
    attr_writer :thread_group
    attr_writer :router_address

    def initialize &assembly
      @assembly = assembly
    end

    class << self
      attr_accessor :address

      def run &assembly
        self.address = Address.build

        _, thread = start include: %i(thread), &assembly

        thread.join
      end

      def build &assembly
        instance = new &assembly
        instance.configure
        instance
      end

      def start include: nil, &assembly
        instance = build &assembly

        start = Messages::Start.new
        instance.writer.(start, address)

        thread = Thread.new do
          instance.start
        end

        thread.name = "Supervisor"

        Destructure.(address, include, { :thread => thread, :actor => instance })
      end
    end

    handle :start do
      thread_group.add Thread.current
      thread_group.enclose

      assembly.(self) if assembly

      :continue
    end

    handle :continue do
      if actor_threads.empty?
        raise error if error

        :stop
      else
        :continue
      end
    end

    handle :actor_started do |message|
      reader = Messaging::Read.build broadcast_address
      output_address = message.actor_address

      add_route = Router::AddRoute.new reader, output_address

      writer.(add_route, router_address)
    end

    handle :actor_crashed do |message|
      self.error ||= message.error

      :shutdown
    end

    handle :shutdown do
      stop = Messages::Stop.new

      writer.(stop, broadcast_address)
      writer.(stop, router_address)

      :continue
    end

    def actor_threads
      list = thread_group.list
      list.delete Thread.current
      list
    end

    def configure
      self.broadcast_address = Address.build
      self.router_address = Router.start
      self.thread_group = ThreadGroup.new
      self.address = self.class.address
    end

    def broadcast_address
      @broadcast_address ||= Address::None
    end

    def router_address
      @router_address ||= Address::None
    end

    def thread_group
      @thread_group ||= Substitutes::ThreadGroup.new
    end
  end
end
