module Actor
  class Queue
    attr_reader :blocked_threads
    attr_reader :consumer_positions
    attr_reader :list
    attr_reader :mutex
    attr_accessor :tail

    def initialize
      @blocked_threads = Set.new
      @consumer_positions = Hash.new 0
      @list = []
      @mutex = Mutex.new
      @tail = 0
    end

    def consumer_started position=nil
      mutex.synchronize do
        position ||= tail

        up position

        position
      end
    end

    def consumer_stopped position
      mutex.synchronize do
        down position
      end
    end

    def read position, wait: nil
      mutex.synchronize do
        relative_position = position - tail

        until list.count > relative_position
          return nil unless wait

          blocked_threads << Thread.current
          mutex.sleep
          blocked_threads.delete Thread.current
        end

        message = list[relative_position]

        up position.next
        down position

        message
      end
    end

    def write message
      # Owning the mutex is not necessary here; the worst that can happen is
      # that occasionally we write a message when there aren't any consumers.
      return unless consumers?

      mutex.synchronize do
        list << message
      end

      blocked_threads.each &:wakeup
    end

    # These query methods are not to be believed without owning the mutex, but
    # might prove useful in cases where precise accuracy is not needed.
    def consumers?
      consumer_positions.any?
    end

    def head
      tail + size
    end

    def size
      list.size
    end

    # These command methods are highly unsafe to call without owning the mutex;
    # therefore, they are marked as private.
    private

    def down position
      ref_count = consumer_positions[position] - 1

      if ref_count.zero?
        consumer_positions.delete position
      else
        consumer_positions[position] = ref_count
      end

      if ref_count.zero?
        if consumers? and position == tail
          new_tail = consumer_positions.keys.min

          expired_messages = new_tail - tail

          list.slice! 0, expired_messages

          self.tail = new_tail
        end
      end

      ref_count
    end

    def up position
      consumer_positions[position] += 1
    end
  end
end
