module Actor
  module Messaging
    class Reader
      def initialize queue
        @queue = queue
      end

      def self.build address
        queue = address.queue

        new queue
      end

      def read wait: nil
        non_block = wait == false

        @queue.deq non_block

      rescue ThreadError
        return nil
      end
    end
  end
end
