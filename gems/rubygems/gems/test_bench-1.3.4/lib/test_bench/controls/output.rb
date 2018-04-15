module TestBench
  module Controls
    module Output
      def self.attach binding, level=nil
        level ||= :verbose

        output = TestBench::Output.build level

        subscription = TestBench::Telemetry::Subscription.new output

        telemetry = TestBench::Telemetry::Registry.get binding
        telemetry.add_observer subscription

        output
      end

      module Device
        def self.tty
          file = non_tty

          def file.tty?
            true
          end

          def file.isatty
            true
          end

          file
        end

        def self.non_tty
          Tempfile.new 'non-tty-control'
        end
      end

      module Error
        def self.example reverse: nil
          reverse ||= false

          error = Controls::Error.example

          file = Controls::Error.file
          line = Controls::Error.line
          method_name = Controls::Error.method_name
          message = Controls::Error.message

          lines = [
            %{#{file}:#{line}:in `#{method_name}': #{message} (#{error.class})\n},
            %{        from #{file}:#{line + 1}:in `#{method_name}'\n},
            %{        from #{file}:#{line + 2}:in `#{method_name}'\n},
          ]

          lines.reverse! if reverse

          lines.join
        end

        module Reversed
          def self.example
            Error.example reverse: true
          end
        end
      end

      module Summary
        def self.example result=nil
          result ||= Result.example

          tests_per_second = Rational result.tests, result.elapsed_time

          error_label = if result.errors == 1 then 'error' else 'errors' end

          "Ran %d tests in 1m1.111s (%.3fs tests/second)\n1 passed, 1 skipped, %d failed, %d total %s" %
            [result.tests, tests_per_second, result.failures, result.errors, error_label]
        end

        module Run
          def self.example result=nil
            result ||= Result.example

            files = if result.files.size == 1 then 'file' else 'files' end

            <<~TEXT
            Finished running #{result.files.size} #{files}
            #{Summary.example result}
            TEXT
          end
        end

        module File
          def self.example result=nil
            path = Path.example
            result ||= Result.example

            <<~TEXT
            Finished running #{path}
            #{Summary.example result}
             
            TEXT
          end
        end
      end
    end
  end
end
