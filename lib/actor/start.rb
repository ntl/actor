module Actor
  class Start
    include Messaging::Send::Dependency

    attr_reader :actor
    attr_accessor :supervisor_address

    def initialize actor
      @actor = actor
    end

    def self.call actor_or_actor_class, *arguments, **keyword_arguments, &block
      if actor_or_actor_class.is_a? Actor and not actor_or_actor_class.is_a? Class
        actor = actor_or_actor_class
      else
        actor = Build.(actor_or_actor_class, *arguments, **keyword_arguments, &block)
      end

      instance = new actor
      instance.send = Messaging::Send.new
      instance.supervisor_address = Supervisor::Address::Get.()
      instance.()
    end

    def call
      send.(Messages::Start, address)

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
      send.(actor_crashed, supervisor_address)
    end

    def actor_started
      actor_started = Messages::ActorStarted.new address, actor
      send.(actor_started, supervisor_address)
    end

    def actor_stopped
      actor_stopped = Messages::ActorStopped.new address, actor
      send.(actor_stopped, supervisor_address)
    end

    def address
      actor.address
    end
  end
end
