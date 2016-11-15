module Actor
  module Messaging
    class Publish
      include Write::Dependency

      attr_reader :addresses

      def initialize
        @addresses = Set.new
      end

      def self.build *addresses
        instance = new

        addresses.each do |address|
          instance.register address
        end

        instance.write = Write.new

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
          write.(message, address, wait: wait)
        end
      end
    end
  end
end
