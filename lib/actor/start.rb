module Actor
  class Start
    include Messaging::Write::Dependency

    attr_reader :actor
    attr_accessor :supervisor_address

    def initialize actor
      @actor = actor
    end

    def self.call actor_class, *arguments, &block
      actor = Build.(actor_class, *arguments, &block)

      instance = new actor
      instance.write = Messaging::Write.new
      instance.supervisor_address = Supervisor::Address::Get.()
      instance.()
    end

    def call
      write.(Messages::Start, address)

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
      actor_crashed = Messages::ActorCrashed.new error
      write.(actor_crashed, supervisor_address)
    end

    def actor_started
      actor_started = Messages::ActorStarted.new address
      write.(actor_started, supervisor_address)
    end

    def actor_stopped
      actor_stopped = Messages::ActorStopped.new address
      write.(actor_stopped, supervisor_address)
    end

    def address
      actor.address
    end
  end
end
