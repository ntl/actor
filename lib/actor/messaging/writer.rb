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

      def self.call message, address
        instance = build address
        instance.(message)
      end

      def call message
        queue.write message
      end
    end
  end
end
