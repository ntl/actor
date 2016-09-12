module Actor
  class Supervisor
    include Actor

    attr_writer :thread_group

    handle :start do
      Continue.new
    end

    handle :continue do |message|
      raise StopIteration if actor_threads.empty?

      message
    end

    def actor_threads
      list = thread_group.list
      list.delete Thread.current
      list
    end

    def thread_group
      @thread_group ||= Substitutes::ThreadGroup.new
    end

    Continue = Class.new
  end
end
