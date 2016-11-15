module Actor
  module Messaging
    class Read
      module Dependency
        attr_writer :read

        def read
          @read ||= Substitute.build
        end
      end
    end
  end
end
