module Fixtures
  module Controls
    module Message
      def self.example
        SomeMessage.new
      end

      SomeMessage = Class.new
    end
  end
end
