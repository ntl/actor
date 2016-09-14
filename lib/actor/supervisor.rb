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

    def self.run &block
      self.address, thread = start include: %i(thread), &block

      thread.join
    end

    def self.address
      @address ||= Address::None
    end

    def self.address= address
      @address = address
    end

    handle :start do
      assembly.(self) if assembly

      :continue
    end

    handle :continue do
      if actor_threads.empty?
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
      thread_group = ThreadGroup.new
      thread_group.add Thread.current
      thread_group.enclose

      self.broadcast_address = Address.build
      self.router_address = Router.start
      self.thread_group = thread_group
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

    ActorCrashed = Struct.new :error
  end
end
