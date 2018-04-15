module TestBench
  module Controls
    class KernelSubstitute
      def self.example file_map=nil
        file_map ||= FileMap.example

        instance = new file_map
        instance
      end

      attr_reader :file_map

      def initialize file_map
        @file_map = file_map
      end

      def load path
        ruby_text = file_map[path]

        TOPLEVEL_BINDING.eval ruby_text, path
      end

      module FileMap
        def self.example
          {
            TestScript::Error.file => TestScript::Error.text,
            TestScript::Failing.file => TestScript::Failing.text,
            TestScript::Passing.file => TestScript::Passing.text,
          }
        end
      end

      module Files
        def self.example
          FileMap.example.keys
        end
      end

      module TestScript
        module Error
          def self.text
            Controls::TestScript::Error.example
          end

          def self.file
            '/error.rb'
          end
        end

        module Failing
          def self.text
            Controls::TestScript::Failing.example
          end

          def self.file
            '/failing.rb'
          end
        end

        module Passing
          def self.text
            Controls::TestScript::Passing.example
          end

          def self.file
            '/passing.rb'
          end
        end
      end
    end
  end
end
