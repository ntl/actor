module Actor
  module Messaging
    class Reader
      class Substitute
        attr_accessor :stopped

        def call wait: nil
          message = messages.shift

          return message if message

          if wait
            raise Wait, "Next message has not yet been written"
          end
        end

        def stop
          self.stopped = true
        end

        def stopped?
          stopped
        end

        def add_message message
          messages << message
        end

        def messages
          @messages ||= []
        end

        Wait = Class.new StandardError

        # Eventide compatibility
        singleton_class.send :alias_method, :build, :new
      end
    end
  end
end
