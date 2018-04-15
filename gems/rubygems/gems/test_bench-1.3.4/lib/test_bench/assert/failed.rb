module TestBench
  class Assert
    class Failed < StandardError
      attr_reader :backtrace_locations

      def initialize backtrace_locations
        @backtrace_locations = backtrace_locations
      end

      def self.build backtrace_location=nil
        backtrace_location ||= caller_locations[0]

        new [backtrace_location]
      end

      def backtrace
        backtrace_locations.map(&:to_s)
      end

      def to_s
        "Assertion failed"
      end
    end
  end
end
