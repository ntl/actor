module Controls
  module Queue
    def self.example(id=nil)
      queue = ::SizedQueue.new(1)
      queue.enq(:some_entry)
      queue
    end

    module Supervisor
      def self.example
        Queue.example
      end
    end

    module Other
      def self.example
        Queue.example
      end
    end
  end
end
