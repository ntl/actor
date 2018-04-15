module TestBench
  class Settings
    class Environment
      attr_reader :settings
      attr_writer :env

      def initialize settings
        @settings = settings
      end

      def self.build settings, env=nil
        env ||= ENV

        instance = new settings
        instance.env = env
        instance
      end

      def self.call *arguments
        instance = build(*arguments)
        instance.()
      end

      def call
        abort_on_error
        color
        exclude_pattern
        reverse_backtraces
        quiet
        record_telemetry
        tests_dir
        verbose
      end

      def activated? value
        if affirmative_pattern.match value
          true
        elsif value.nil? or negative_pattern.match value
          false
        else
          invalid_boolean value
        end
      end

      def affirmative_pattern
        @@affirmative_pattern ||= %r{\A(?:on|yes|y|1)\z}i
      end

      def color
        if deactivated? env['TEST_BENCH_COLOR']
          settings.color = false
        elsif activated? env['TEST_BENCH_COLOR']
          settings.color = true
        end
      end

      def deactivated? value
        if negative_pattern.match value
          true
        elsif value.nil? or affirmative_pattern.match value
          false
        else
          invalid_boolean value
        end
      end

      def env
        @env ||= {}
      end

      def abort_on_error
        if activated? env['TEST_BENCH_ABORT_ON_ERROR']
          settings.abort_on_error = true
        end
      end

      def exclude_pattern
        if pattern = env['TEST_BENCH_EXCLUDE_PATTERN']
          settings.exclude_pattern = pattern
        end
      end

      def invalid_boolean value
        raise ArgumentError, %{Invalid boolean value #{value.inspect}; values that are toggled can be set via "on" or "off", "yes" or "no", "y" or "n", or "0" or "1".}
      end

      def negative_pattern
        @@negative_pattern ||= %r{\A(?:off|no|n|0)\z}i
      end

      def record_telemetry
        if activated? env['TEST_BENCH_RECORD_TELEMETRY']
          settings.record_telemetry = true
        end
      end

      def reverse_backtraces
        if activated? env['TEST_BENCH_REVERSE_BACKTRACES']
          settings.reverse_backtraces = true
        end
      end

      def quiet
        if activated? env['TEST_BENCH_QUIET']
          settings.lower_verbosity
          settings.lower_verbosity
        end
      end

      def tests_dir
        tests_dir = env['TEST_BENCH_TESTS_DIR']

        settings.tests_dir = tests_dir if tests_dir
      end

      def verbose
        if activated? env['TEST_BENCH_VERBOSE']
          settings.raise_verbosity
          settings.raise_verbosity
        end
      end
    end
  end
end
