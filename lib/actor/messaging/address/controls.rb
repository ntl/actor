module Actor
  module Messaging
    class Address
      module Controls
        def write message
          queue.enq message
        end
      end
    end
  end
end
