module Actor
  module Messages
    module Start
      extend Messaging::Message
    end

    ActorStarted = Struct.new :address do
      include Messaging::Message
    end

    ActorStopped = Struct.new :address do
      include Messaging::Message
    end

    ActorCrashed = Struct.new :error do
      include Messaging::Message
    end

    module Suspend
      extend Messaging::Message
    end

    module Resume
      extend Messaging::Message
    end

    module Shutdown
      extend Messaging::Message
    end

    module Stop
      extend Messaging::Message
    end
  end
end
