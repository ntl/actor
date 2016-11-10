module Fixtures
  module Controls
    module Message
      def self.example
        SomeMessage.new
      end

      class SomeMessage
        include ::Actor::Messaging::Message
      end
    end
  end
end
