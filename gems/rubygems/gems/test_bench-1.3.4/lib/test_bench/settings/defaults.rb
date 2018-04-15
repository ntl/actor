module TestBench
  class Settings
    module Defaults
      def self.abort_on_error
        false
      end

      def self.color
        nil
      end
      
      def self.exclude_pattern
        "_init\\.rb$"
      end

      def self.record_telemetry
        false
      end

      def self.reverse_backtraces
        false
      end

      def self.tests_dir
        'tests'
      end
    end
  end
end
