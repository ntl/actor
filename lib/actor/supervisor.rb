module Actor
  class Supervisor
    include Actor

    attr_accessor :error
    attr_writer :thread_group

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

    def actor_threads
      list = thread_group.list
      list.delete Thread.current
      list
    end

    def thread_group
      @thread_group ||= Substitutes::ThreadGroup.new
    end

    ActorCrashed = Struct.new :error
    Continue = Class.new
  end
end
