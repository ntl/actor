module Actor
  module Controls
    module Time
      class Clock
        attr_reader :step_function
        attr_accessor :time

        def initialize time, step_function
          @time = time
          @step_function = step_function
        end

        def self.build steps
          time = Time.reference

          step_function = steps.cycle

          new time, step_function
        end

        def now
          now = time

          self.time += step_function.next

          now
        end
      end
    end
  end
end
