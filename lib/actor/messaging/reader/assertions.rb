module Actor
  module Messaging
    class Reader
      module Assertions
        def queue? queue
          @queue == queue
        end
      end
    end
  end
end
