module Actor
  module Messaging
    class Read
      attr_reader :queue
      attr_reader :stream

      def initialize queue, stream
        @queue = queue
        @stream = stream
      end

      def self.build address, queue=nil
        queue ||= Queue.new

        stream = address.stream
        stream.add_queue queue

        instance = new queue, stream
        instance
      end

      def self.call address, wait: nil
        instance = build address
        instance.(wait: wait)
      end

      def self.configure receiver, address, attr_name: nil
        attr_name ||= :reader

        instance = build address
        receiver.public_send "#{attr_name}=", instance
        instance
      end

      def call wait: nil
        if wait
          queue.deq
        else
          non_block = true

          begin
            queue.deq non_block
          rescue ThreadError
            nil
          end
        end
      end

      def messages_available?
        not queue.empty?
      end
    end
  end
end
