module Fixtures
  module Controls
    module Message
      def self.example
        SomeMessage.new
      end

      class SomeMessage
        include ::Actor::Messaging::Message
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

          ::Actor::Messages::ActorStarted.new address
        end

        def self.pair
          address = Address.example

          actor_started = example address
          actor = Actor.example address

          return actor_started, actor
        end
      end

      module ActorStopped
        def self.example address=nil
          address ||= Address.example

          ::Actor::Messages::ActorStopped.new address
        end

        def self.pair
          address = Address.example

          actor_stopped = example address
          actor = Actor.example address

          return actor_stopped, actor
        end
      end

      module Shutdown
        def self.example
        end
      end
    end
  end
end
