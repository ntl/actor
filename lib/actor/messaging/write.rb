module Actor
  module Messaging
    class Write
      def self.call message, address
        instance = new
        instance.(message, address)
      end

      def call message, address
        stream = address.stream

        stream.write message
      end
    end
  end
end
