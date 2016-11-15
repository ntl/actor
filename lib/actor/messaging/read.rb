module Actor
  module Messaging
    class Read
      attr_reader :queue

      def initialize queue
        @queue = queue
      end

      def self.build address
        queue = address.queue

        new queue
      end

      def self.call address, wait: nil
        instance = build address

        instance.(wait: wait)
      end

      def call wait: nil
        non_block = wait == false

        queue.deq non_block

      rescue ThreadError
        return nil
      end
    end
  end
end
