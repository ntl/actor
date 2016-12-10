module Actor
  module Messaging
    class Publish
      include Send::Dependency

      attr_reader :addresses

      def initialize
        @addresses = Set.new
      end

      def self.build *addresses
        instance = new

        addresses.each do |address|
          instance.register address
        end

        instance.send = Send.new

        instance
      end

      def register address
        addresses << address
      end

      def unregister address
        addresses.delete address
      end

      def call message, wait: nil
        addresses.each do |address|
          send.(message, address, wait: wait)
        end
      end
    end
  end
end
