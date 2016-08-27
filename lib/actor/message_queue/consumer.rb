module Actor
  class MessageQueue
    class Consumer
      attr_reader :queue
      attr_accessor :position

      def initialize queue, position
        @queue = queue
        @position = position
      end

      def self.build queue
        position = queue.consumer_started

        new queue, position
      end

      def self.start queue, &block
        instance = build queue

        begin
          block.(instance)
          return instance
        ensure
          instance.stop
        end
      end

      def next block: nil
        message = queue.read position, block: block

        return nil if message.nil?

        self.position = position.next

        message
      end

      def stop
        queue.consumer_stopped position
      end
    end
  end
end
