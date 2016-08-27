module Actor
  module Controls
    module Statistics
      module ElapsedTime
        module Minimum
          def self.configure_timer receiver
            ElapsedTime.configure_timer receiver, elapsed_times
          end

          def self.elapsed_times
            [111, 11, 1]
          end

          def self.value
            1
          end
        end
      end
    end
  end
end
