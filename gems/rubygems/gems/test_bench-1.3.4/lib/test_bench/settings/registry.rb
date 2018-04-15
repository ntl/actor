module TestBench
  class Settings
    module Registry
      extend self

      def registry
        @registry ||= TestBench::Registry.build do
          Settings.new
        end
      end

      def get binding
        registry.get binding
      end
    end
  end
end
