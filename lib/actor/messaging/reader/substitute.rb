module Actor
  module Messaging
    class Reader
      class Substitute < Reader
        attr_writer :next_message

        def self.build
          queue = Queue::Substitute.new

          instance = new queue
          instance.extend Controls
          instance
        end

        def read wait: nil
          if @next_message.nil?
            super
          else
            @next_message
          end
        end

        module Controls
          def add message
            @next_message = message
          end
        end
      end
    end
  end
end
