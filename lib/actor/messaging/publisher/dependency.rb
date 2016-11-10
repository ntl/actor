module Actor
  module Messaging
    class Publisher
      module Dependency
        attr_writer :publisher

        def publisher
          @publisher ||= Substitute.build
        end
      end
    end
  end
end
