module Actor
  module Messages
    ActorStarted = Struct.new :address do
      include Messaging::Message
    end

    ActorStopped = Struct.new :address do
      include Messaging::Message
    end

    ActorCrashed = Struct.new :error do
      include Messaging::Message
    end

    module Stop
      extend Messaging::Message
    end

    module Shutdown
      extend Messaging::Message
    end
  end
end
