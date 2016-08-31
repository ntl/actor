module Actor
  module Messaging
    class Address
      attr_reader :id
      attr_reader :queue

      def initialize id, queue
        @id = id
        @queue = queue
      end

      def self.build
        id = SecureRandom.uuid
        queue = Queue.new

        new id, queue
      end

      def reader_count
        queue.reader_count
      end

      def inspect
        %{#<#{self.class.name} id=#{id.inspect}, queue=#{queue_tail}..#{queue_head}, readers=#{reader_count}>}
      end

      def queue_head
        queue.head
      end

      def queue_tail
        queue.tail
      end

      def queue_size
        queue.size
      end
    end
  end
end
