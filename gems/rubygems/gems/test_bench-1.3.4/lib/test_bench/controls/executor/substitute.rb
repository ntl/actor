module TestBench
  module Controls
    module Executor
      class Substitute
        attr_writer :telemetry

        def call files
          files.each do |file|
            executed_files << file
          end
        end

        def executed_files
          @executed_files ||= []
        end

        module Assertions
          def executed? *files
            files.all? do |file|
              executed_files.include? file
            end
          end
        end
      end
    end
  end
end
