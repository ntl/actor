module Actor
  module Messaging
    class Reader
      module Dependency
        attr_writer :reader

        def reader
          @reader ||= Substitute.new
        end
      end
    end
  end
end
