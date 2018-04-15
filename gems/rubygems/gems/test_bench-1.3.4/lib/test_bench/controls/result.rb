module TestBench
  module Controls
    module Result
      def self.example file=nil, failures: nil, errors: nil
        failures ||= 1
        errors ||= 1
        file ||= Path.example

        TestBench::Result.new(
          [file],   # files
          1,        # passes
          failures, # failures
          1,        # skips
          11,       # assertions
          errors,   # errors
          t0,       # start_time
          t1,       # stop_time
        )
      end

      def self.t0
        Clock::Elapsed.t0
      end

      def self.t1
        Clock::Elapsed.t1
      end

      def self.elapsed_time
        "1m1.111s"
      end

      module Error
        def self.example
          Result.example file, :errors => 1, :failures => 0
        end

        def self.file
          'error.rb'
        end
      end

      module Failed
        def self.example
          Result.example file, :errors => 0, :failures => 1
        end

        def self.file
          'fail.rb'
        end
      end

      module Passed
        def self.example
          Result.example file, :errors => 0, :failures => 0
        end

        def self.file
          'pass.rb'
        end
      end
    end
  end
end
