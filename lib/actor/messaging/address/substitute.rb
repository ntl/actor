module Actor
  module Messaging
    class Address
      class Substitute < None
        def self.build
          instance = super
          instance.extend(Controls)
          instance
        end

        def queue_depth
          @queue_depth ||= super
        end

        module Controls
          attr_writer :queue_depth
        end
      end
    end
  end
end
