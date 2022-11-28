module Actor
  module Messaging
    module Queue
      def self.get(max_size: nil)
        max_size ||= Defaults.maximum_size

        SizedQueue.new(max_size)
      end

      module Defaults
        def self.maximum_size
          size = ENV['ACTOR_MAXIMUM_QUEUE_SIZE']

          return size.to_i if size

          1_000
        end
      end
    end
  end
end
