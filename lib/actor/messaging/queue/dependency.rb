module Actor
  module Messaging
    module Queue
      module Dependency
        attr_writer :queue
        def queue
          @queue ||= Substitute.build
        end

        alias_method :queue, :queue
        alias_method :queue=, :queue=
      end
    end
  end
end
