module Actor
  module Messaging
    class Reader
      attr_reader :queue_reader

      def initialize queue_reader
        @queue_reader = queue_reader
      end

      def self.build address
        queue = address.queue

        queue_reader = Queue::Reader.build queue

        new queue_reader
      end

      def next wait: nil
        queue_reader.read wait: wait
      end

      def stop
        queue_reader.stop
      end

      def stopped?
        queue_reader.stopped?
      end
    end
  end
end
