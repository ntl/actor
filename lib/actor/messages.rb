module Actor
  module Messages
    class Start
      include Messaging::Message
    end

    class Stop
      include Messaging::Message
    end
  end
end
