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
      def self.example queue=nil
        queue ||= Queue.example

        actor = Actor.example queue

        ::Actor::Messages::ActorStarted.new queue, actor
      end

      def self.pair
        queue = Queue.example

        actor_started = example queue

        actor = actor_started.actor

        return actor_started, actor
      end
    end

    module ActorStopped
      def self.example queue=nil
        queue ||= Queue.example

        actor = Actor.example queue

        ::Actor::Messages::ActorStopped.new queue, actor
      end

      def self.pair
        queue = Queue.example

        actor_stopped = example queue

        actor = actor_stopped.actor

        return actor_stopped, actor
      end
    end
  end
end
