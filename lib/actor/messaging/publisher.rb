module Actor
  module Messaging
    class Publisher
      include Writer::Dependency

      def initialize
        @addresses = Set.new
      end

      def self.build *addresses
        instance = new

        addresses.each do |address|
          instance.register address
        end

        instance.writer = Writer.new

        instance
      end

      def register address
        @addresses << address
      end

      def unregister address
        @addresses.delete address
      end

      def publish message, wait: nil
        @addresses.each do |address|
          writer.write message, address, wait: wait
        end
      end
    end
  end
end
