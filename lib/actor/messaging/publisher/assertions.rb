module Actor
  module Messaging
    class Publisher
      module Assertions
        def registered? address
          @queues.include? address.queue
        end
      end
    end
  end
end
