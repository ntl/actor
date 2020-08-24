module Actor
  class Start
    include Messaging::Send::Dependency

    attr_reader :actor
    attr_accessor :supervisor_queue

    def initialize actor
      @actor = actor
    end

    def self.call actor_class, *arguments, &block
      actor = Build.(actor_class, *arguments, &block)

      instance = new actor
      instance.send = Messaging::Send.new
      instance.supervisor_queue = Supervisor::Queue::Get.()
      instance.()
    end

    def call
      send.(Messages::Start, queue)

      thread = Thread.new do
        actor_started

        begin
          actor.run_loop
          actor_stopped
        rescue => error
          actor_crashed error
        end
      end

      return actor, thread
    end

    def actor_crashed error
      actor_crashed = Messages::ActorCrashed.new error, actor
      send.(actor_crashed, supervisor_queue)
    end

    def actor_started
      actor_started = Messages::ActorStarted.new queue, actor
      send.(actor_started, supervisor_queue)
    end

    def actor_stopped
      actor_stopped = Messages::ActorStopped.new queue, actor
      send.(actor_stopped, supervisor_queue)
    end

    def queue
      actor.queue
    end
  end
end
