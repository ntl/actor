module Actor
  module Messaging
    class Publish
      module Dependency
        attr_writer :publish

        def publish
          @publish ||= Substitute.build
        end
      end
    end
  end
end
