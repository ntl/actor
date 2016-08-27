module Actor
  module Controls
    module Statistics
      def self.example executions=nil
        executions ||= 1

        statistics = ::Actor::Statistics.new

        executions.times do
          timer = Controls::Statistics::Timer.example
          statistics.timer = timer

          statistics.executing_action
          statistics.action_executed
        end

        statistics
      end
    end
  end
end
