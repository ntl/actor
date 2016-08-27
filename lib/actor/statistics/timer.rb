module Actor
  class Statistics
    class Timer
      attr_writer :clock
      attr_accessor :start_time
      attr_accessor :stop_time

      def clock
        @clock ||= Time
      end

      def reset
        self.stop_time = nil
        self.start_time = clock.now

        start_time
      end

      def stop
        self.stop_time = stop_time = clock.now

        return start_time, stop_time
      end
    end
  end
end
