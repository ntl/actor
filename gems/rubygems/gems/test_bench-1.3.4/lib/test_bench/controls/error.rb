module TestBench
  module Controls
    class Error < StandardError
      def self.example
        new backtrace_locations
      end

      def self.file
        Path.example
      end

      def self.line
        1
      end

      def self.message
        'Some error'
      end

      def self.method_name
        'some_method'
      end

      def self.backtrace_locations
        [
          BacktraceLocation.new(file, line, method_name),
          BacktraceLocation.new(file, line + 1, method_name),
          BacktraceLocation.new(file, line + 2, method_name),
        ]
      end

      class BacktraceLocation
        attr_reader :label
        attr_reader :lineno
        attr_reader :path

        def initialize path, lineno, label
          @label = label
          @lineno = lineno
          @path = path
        end

        def to_s
          "#{path}:#{lineno}:in `#{label}'"
        end
      end

      attr_reader :backtrace_locations

      def initialize backtrace_locations
        @backtrace_locations = backtrace_locations
      end

      def backtrace
        backtrace_locations.map(&:to_s)
      end

      def to_s
        self.class.message
      end
    end
  end
end
