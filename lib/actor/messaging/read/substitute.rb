module Actor
  module Messaging
    class Read
      class Substitute < Read
        attr_accessor :next_message

        def self.build
          queue = Queue::Substitute.new

          instance = new(queue)
          instance.extend(Controls)
          instance
        end

        def call(wait: nil)
          if next_message.nil?
            super
          else
            next_message
          end
        end

        module Controls
          def add(message)
            self.next_message = message
          end
        end
      end
    end
  end
end
