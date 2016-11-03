module Actor
  module Messaging
    Address = Struct.new :id, :queue

    class Address
      def self.build max_queue_size: nil
        id = SecureRandom.uuid
        queue = Queue.get max_size: max_queue_size

        new id, queue
      end

      def actors_waiting
        queue.num_waiting
      end

      def queue_size
        queue.size
      end

      def queue_max_size
        queue.max
      end
    end
  end
end
