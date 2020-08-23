module Actor
  module Messaging
    class Read
      attr_reader :queue

      def initialize queue
        @queue = queue
      end

      def self.build queue
        new queue
      end

      def self.call queue, wait: nil
        instance = build queue

        instance.(wait: wait)
      end

      def call wait: nil
        non_block = wait == false

        queue.deq non_block

      rescue ThreadError
        return nil
      end

      def queue? queue
        queue?(queue)
      end

      def next_message? message
        begin
          next_message = @queue.deq true
        rescue ThreadError
          return false
        end

        next_message == message
      end

      def queue? queue
        self.queue == queue
      end
    end
  end
end
