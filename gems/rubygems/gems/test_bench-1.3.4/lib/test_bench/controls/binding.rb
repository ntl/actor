module TestBench
  module Controls
    module Binding
      def self.example
        mod = Module.new do
          extend TestBench::Structure

          def self.get_binding
            binding
          end
        end

        mod.get_binding
      end
    end
  end
end
