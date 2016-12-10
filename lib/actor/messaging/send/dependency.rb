module Actor
  module Messaging
    class Send
      module Dependency
        attr_writer :send

        def send
          @send ||= Substitute.build
        end
      end
    end
  end
end
