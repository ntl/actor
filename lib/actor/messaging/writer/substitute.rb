module Actor
  module Messaging
    class Writer
      class Substitute
        def write message
          messages << message
        end

        def messages
          @messages ||= []
        end

        module Assertions
          def written? &block
            block ||= proc { true }

            messages.any? &block
          end
        end

        # Eventide compatibility
        singleton_class.send :alias_method, :build, :new
      end
    end
  end
end
