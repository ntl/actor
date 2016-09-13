module Actor
  module Messaging
    class Write
      def self.call message, address
        instance = new
        instance.(message, address)
      end

      def self.configure receiver, attr_name: nil
        attr_name ||= :writer

        instance = new
        receiver.public_send "#{attr_name}=", instance
        instance
      end

      def call message, address
        stream = address.stream

        stream.write message
      end
    end
  end
end
