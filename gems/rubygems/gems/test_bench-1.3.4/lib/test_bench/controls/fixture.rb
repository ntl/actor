module TestBench
  module Controls
    module Fixture
      class Example
        include TestBench::Fixture

        def example_context
          context "Some context" do end
        end

        def example_test
          test "Some test" do end
        end

        def example_assertions
          assert true
          refute false
        end
      end

      def self.example
        Example.new
      end

      def self.pair
        binding = Binding.example
        telemetry = TestBench::Telemetry::Registry.get binding

        fixture = example
        fixture.structure = binding.receiver

        return fixture, telemetry
      end
    end
  end
end
