module Actor
  module Messaging
    class Writer
      module Dependency
        attr_writer :writer

        def writer
          @writer ||= Substitute.new
        end
      end
    end
  end
end
