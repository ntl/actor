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

        module Controls
          def add message
            @queue.add message
          end
        end
      end
    end
  end
end
