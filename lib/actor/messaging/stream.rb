module Actor
  module Messaging
    class Stream
      def initialize
        @buffer = []
        @mutex = Mutex.new
      end

      def read position
        @buffer[position]
      end

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
