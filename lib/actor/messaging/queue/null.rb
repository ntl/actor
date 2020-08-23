module Actor
  module Messaging
    module Queue
      module Null
        def self.instance
          @instance ||= build
        end

        def self.build
          queue = Substitute.build
          queue.extend(self)
          queue
        end
      end
    end
  end
end
