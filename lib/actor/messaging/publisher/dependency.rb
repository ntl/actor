module Actor
  module Messaging
    class Publisher
      module Dependency
        attr_writer :publisher

        def publisher
          @publisher ||= Substitute.new
        end
      end
    end
  end
end
