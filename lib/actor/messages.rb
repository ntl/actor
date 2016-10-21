module Actor
  module Messages
    class Start
      include Messaging::Message
    end

    ActorStarted = Struct.new :actor_address do
      include Messaging::Message
    end

    ActorCrashed = Struct.new :error do
      include Messaging::Message
    end

    class Stop
      include Messaging::Message
    end
  end
end
