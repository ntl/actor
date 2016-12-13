module Controls
  module Message
    def self.example
      SomeMessage.new
    end

    class SomeMessage
      include ::Actor::Messaging::Message
    end

    class OtherMessage
      include ::Actor::Messaging::Message
    end

    module ModuleMessage
      extend ::Actor::Messaging::Message
    end

    module ActorCrashed
      def self.example
        error = Error.example

        ::Actor::Messages::ActorCrashed.new error
      end
    end

    module ActorStarted
      def self.example address=nil
        address ||= Address.example

        actor = Actor.example address

        ::Actor::Messages::ActorStarted.new address, actor
      end

      def self.pair
        address = Address.example

        actor_started = example address

        actor = actor_started.actor

        return actor_started, actor
      end
    end

    module ActorStopped
      def self.example address=nil
        address ||= Address.example

        actor = Actor.example address

        ::Actor::Messages::ActorStopped.new address, actor
      end

      def self.pair
        address = Address.example

        actor_stopped = example address

        actor = actor_stopped.actor

        return actor_stopped, actor
      end
    end
  end
end
