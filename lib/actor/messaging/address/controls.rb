module Actor
  module Messaging
    class Address
      module Controls
        def send(message)
          queue.enq(message)
        end
      end
    end
  end
end
