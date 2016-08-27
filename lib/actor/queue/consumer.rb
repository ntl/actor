module Actor
  class Queue
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

      def next wait: nil
        object = queue.read position, wait: wait

        return nil if object.nil?

        self.position = position.next

        object
      end

      def stop
        queue.consumer_stopped position
      end
    end
  end
end
