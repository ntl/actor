module TestBench
  class Result
    module Assertions
      def executed? *control_files
        control_files.all? do |control_file|
          files.include? control_file
        end
      end
    end
  end
end
