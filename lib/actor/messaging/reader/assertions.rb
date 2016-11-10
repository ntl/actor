module Actor
  module Messaging
    class Reader
      module Assertions
        def address? address
          queue? address.queue
        end

        def queue? queue
          @queue == queue
        end
      end
    end
  end
end
