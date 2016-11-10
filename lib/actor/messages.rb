module Actor
  module Messages
    ActorStarted = Struct.new :address do
      include Messaging::Message
    end

    ActorStopped = Struct.new :address do
      include Messaging::Message
    end
  end
end
