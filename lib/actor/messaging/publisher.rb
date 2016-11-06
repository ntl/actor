module Actor
  module Messaging
    class Publisher
      def initialize
        @queues = Set.new
      end

      def self.build *addresses
        instance = new

        addresses.each do |address|
          instance.register address
        end

        instance
      end

      def register address
        @queues << address.queue
      end

      def unregister address
        @queues.delete address.queue
      end

      def publish message, wait: nil
        non_block = wait == false

        @queues.each do |queue|
          queue.enq message, non_block
        end

      rescue ThreadError
        raise WouldBlockError
      end

      WouldBlockError = Class.new StandardError
    end
  end
end
