module Actor
  module Messaging
    class Write
      module Dependency
        attr_writer :write

        def write
          @write ||= Substitute.build
        end
      end
    end
  end
end
