module Actor
  module Messaging
    class Read
      module Assertions
        def address? address
          queue? address.queue
        end

        def next_message? message
          begin
            next_message = @queue.deq true
          rescue ThreadError
            return false
          end

          next_message == message
        end

        def queue? queue
          self.queue == queue
        end
      end
    end
  end
end
