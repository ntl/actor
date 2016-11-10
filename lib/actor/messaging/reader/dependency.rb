module Actor
  module Messaging
    class Reader
      module Dependency
        attr_writer :reader

        def reader
          @reader ||= Substitute.build
        end
      end
    end
  end
end
