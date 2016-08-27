module Actor
  module Messaging
    class Writer
      attr_reader :queue

      def initialize queue
        @queue = queue
      end

      def self.build address
        queue = address.queue

        new queue
      end

      def self.write message, address
        instance = build address
        instance.write message
      end

      def write message
        queue.write message
      end
    end
  end
end
