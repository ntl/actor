module Actor
  module Messaging
    class Writer
      module Assertions
        def registered? address
          @queues.include? address.queue
        end
      end
    end
  end
end
