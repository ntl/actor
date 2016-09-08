module Actor
  class Stream
    attr_reader :queues

    def initialize
      @queues = Set.new
    end

    def add_queue queue
      queues << queue
    end

    def remove_queue queue
      queues.delete queue
    end

    def write message
      queues.each do |queue|
        queue.enq message
      end
    end
  end
end
