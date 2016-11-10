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

    Shutdown = Class.new do
      include Messaging::Message

      def == other_message
        other_message.instance_of? Shutdown
      end
    end
  end
end
