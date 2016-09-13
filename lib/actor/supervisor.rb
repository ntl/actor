module Actor
  class Supervisor
    include Actor

    attr_writer :broadcast_address
    attr_accessor :error
    attr_writer :thread_group
    attr_writer :router_address

    handle :start do
      Continue.new
    end

    handle :continue do |message|
      raise StopIteration if actor_threads.empty?

      message
    end

    handle :actor_crashed do |message|
      self.error ||= message.error

      Messages::Stop.new
    end

    handle :actor_started do |message|
      reader = Messaging::Read.build broadcast_address
      output_address = message.actor_address

      add_route = Router::AddRoute.new reader, output_address

      writer.(add_route, router_address)
    end

    def actor_threads
      list = thread_group.list
      list.delete Thread.current
      list
    end

    def broadcast_address
      @broadcast_address ||= Address::Substitute.build
    end

    def router_address
      @router_address ||= Address::Substitute.build
    end

    def thread_group
      @thread_group ||= Substitutes::ThreadGroup.new
    end

    ActorCrashed = Struct.new :error
    Continue = Class.new
  end
end
