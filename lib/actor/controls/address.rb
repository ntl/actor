module Actor
  module Controls
    module Address
      def self.example id_offset=nil, stream: nil
        stream ||= Stream.new

        uuid = UUID.example id_offset

        ::Actor::Address.new stream, uuid
      end

      def self.pair
        stream = Stream.new

        queue = Queue.new
        stream.add_queue queue

        address = example stream: stream

        return address, queue
      end
    end
  end
end
