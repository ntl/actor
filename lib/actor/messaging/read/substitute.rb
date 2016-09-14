module Actor
  module Messaging
    class Read
      class Substitute
        def call wait: nil
          message = messages.shift

          if message.nil? and wait
            raise WouldWait
          end

          message
        end

        def messages_available?
          messages.any?
        end

        def add_message message
          messages << message
        end

        def messages
          @messages ||= []
        end

        WouldWait = Class.new StandardError

        singleton_class.send :alias_method, :build, :new
      end
    end
  end
end
