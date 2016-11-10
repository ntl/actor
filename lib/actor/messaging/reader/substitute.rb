module Actor
  module Messaging
    class Reader
      class Substitute < Reader
        def initialize
          @queue = Queue::Substitute.build
        end

        def self.build
          instance = new
          instance.extend Controls
          instance
        end

        def read wait: nil
          wait = true if wait.nil?

          @queue.deq !wait
        end

        def message= message
          @queue.read_message = message
        end

        module Controls
          def message= message
            @queue.read_message = message
          end
        end
      end
    end
  end
end
