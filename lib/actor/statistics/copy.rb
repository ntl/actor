module Actor
  class Statistics
    module Copy
      def self.call target, statistics
        target.average_elapsed_time = statistics.average_elapsed_time
        target.elapsed_time = statistics.elapsed_time
        target.executions = statistics.executions
        target.last_execution_time = statistics.last_execution_time
        target.minimum_elapsed_time = statistics.minimum_elapsed_time
        target.maximum_elapsed_time = statistics.maximum_elapsed_time
        target.start_time = statistics.start_time

        deviation, _, _, percent = statistics.standard_deviation
        target.standard_deviation_amount = deviation
        target.standard_deviation_percent = percent
      end
    end
  end
end
