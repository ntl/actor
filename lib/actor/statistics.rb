module Actor
  class Statistics
    attr_accessor :elapsed_time
    attr_accessor :executions
    attr_accessor :last_execution_time
    attr_accessor :maximum_elapsed_time
    attr_accessor :minimum_elapsed_time
    attr_accessor :start_time
    attr_accessor :sum_elapsed_time_squared
    attr_writer :timer

    def initialize
      @executions = 0
      @elapsed_time = 0
      @sum_elapsed_time_squared = 0
    end

    def self.build actor
      instance = new
      actor.add_observer instance
      instance
    end

    def executing_action
      now = timer.reset

      self.start_time ||= now
    end

    def action_executed
      start_time, stop_time = timer.stop

      elapsed_time = stop_time - start_time

      self.elapsed_time += elapsed_time
      self.executions += 1
      self.last_execution_time = stop_time
      self.maximum_elapsed_time = [elapsed_time, maximum_elapsed_time].compact.max
      self.minimum_elapsed_time = [elapsed_time, minimum_elapsed_time].compact.min
      self.sum_elapsed_time_squared += elapsed_time ** 2
    end

    def average_elapsed_time
      return nil if executions.zero?

      Rational elapsed_time, executions
    end

    def standard_deviation
      return nil if executions.zero?

      average_elapsed_time = self.average_elapsed_time

      deviation = Math.sqrt(
        [
          0,
          Rational(sum_elapsed_time_squared, executions) -
          average_elapsed_time ** 2
        ].max
      )

      min = average_elapsed_time - deviation
      max = average_elapsed_time + deviation

      unless average_elapsed_time.zero?
        percent = Rational(deviation * 100, average_elapsed_time)
      end

      return deviation, min, max, percent
    end

    def timer
      @timer ||= Timer.new
    end
  end
end
