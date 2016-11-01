module Actor
  module Messaging
    class Stream
      def initialize
        @buffer = []
        @mutex = Mutex.new
        @reader_positions = Hash.new 0
        @tail = 0
      end

      # XXX - tests don't prove that read can wait for a buffer to fill up, or
      # that the position is not advanced if there is no data and wait is not
      # specified
      def read position
        next_position = position.next

        @mutex.synchronize do
          data = @buffer[position - @tail]

          reader_count = @reader_positions[position] -= 1

          if position == @tail and reader_count.zero?
            @buffer.shift
            @tail = next_position
          end

          @reader_positions[next_position] += 1

          return data
        end
      end
      # /XXX

      # XXX - tests don't prove that start_reader is thread safe
      def start_reader
        reader_position = @tail

        @reader_positions[reader_position] += 1

        @tail
      end
      # /XXX

      def write message
        @mutex.synchronize do
          @buffer << message
        end
      end

      module Assertions
        def buffer? array=nil, &block
          if array
            @buffer == array
          else
            block.(@buffer)
          end
        end
      end

      module Controls
        attr_writer :buffer
      end
    end
  end
end
