module TestBench
  module Controls
    module Telemetry
      def self.example failed=nil
        telemetry = TestBench::Telemetry.new
        telemetry.failed = failed
        telemetry
      end

      module Failed
        def self.example
          Telemetry.example true
        end
      end

      module Passed
        def self.example
          Telemetry.example false
        end
      end
    end
  end
end
