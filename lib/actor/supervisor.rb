module Actor
  class Supervisor
    include Module

    include Messaging::Publisher::Dependency

    handle Messages::ActorStarted do |message|
      publisher.register message.address
    end

    handle Messages::ActorStopped do |message|
      publisher.unregister message.address
    end
  end
end
