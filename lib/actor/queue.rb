module Actor
  class Queue
    attr_reader :blocked_threads
    attr_reader :reader_positions
    attr_reader :list
    attr_reader :mutex
    attr_accessor :tail

    def initialize
      @blocked_threads = Set.new
      @reader_positions = Hash.new 0
      @list = []
      @mutex = Mutex.new
      @tail = 0
    end

    def head
      tail + size
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

        object = list[relative_position]

        up position.next
        down position

        object
      end
    end

    def reader_started position=nil
      mutex.synchronize do
        position ||= tail

        up position

        position
      end
    end

    def readers?
      reader_positions.any?
    end

    def reader_count
      reader_positions.values.reduce &:+
    end

    def reader_stopped position
      mutex.synchronize do
        down position
      end
    end

    def size
      list.size
    end

    def write object
      # Owning the mutex is not necessary here; the worst that can happen is
      # that occasionally we write a object when there aren't any readers.
      return unless readers?

      mutex.synchronize do
        list << object
      end

      blocked_threads.each &:wakeup
    end

    # These command methods are highly unsafe to call without owning the mutex;
    # therefore, they are marked as private.
    private

    def down position
      ref_count = reader_positions[position] - 1

      if ref_count.zero?
        reader_positions.delete position
      else
        reader_positions[position] = ref_count
      end

      if ref_count.zero?
        if readers? and position == tail
          new_tail = reader_positions.keys.min

          expired_objects = new_tail - tail

          list.slice! 0, expired_objects

          self.tail = new_tail
        end
      end

      ref_count
    end

    def up position
      reader_positions[position] += 1
    end
  end
end
