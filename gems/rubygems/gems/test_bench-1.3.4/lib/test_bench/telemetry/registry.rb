module TestBench
  class Telemetry
    module Registry
      extend self

      def registry
        @registry ||= TestBench::Registry.build do
          Telemetry.build
        end
      end

      def get binding
        registry.get binding
      end
    end
  end
end
