module Actor
  module Controls
    module Address
      def self.example id_offset=nil, stream: nil
        stream ||= Stream.new

        uuid = UUID.example id_offset

        ::Actor::Address.new stream, uuid
      end

      def self.pair id_offset=nil
        stream = Stream.new

        queue = Queue.new
        stream.add_queue queue

        address = example id_offset, stream: stream

        return address, queue
      end

      module Actor
        def self.example
          Address.example 0
        end
      end

      module Supervisor
        def self.example
          Address.example 1
        end
      end

      module Router
        def self.example
          Address.example 2
        end
      end
    end
  end
end
