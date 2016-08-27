module Actor
  module Messaging
    class Consumer
      attr_reader :reader

      def initialize reader
        @reader = reader
      end

      def self.build address
        queue = address.queue

        reader = Queue::Reader.build queue

        new reader
      end

      def next wait: nil
        reader.read wait: wait
      end

      def stop
        reader.stop
      end

      def stopped?
        reader.stopped?
      end
    end
  end
end
