# See https://rosettacode.org/wiki/Standard_deviation
module Actor
  module Controls
    module Statistics
      module ElapsedTime
        module StandardDeviation
          def self.configure_timer receiver
            ElapsedTime.configure_timer receiver, elapsed_times
          end

          def self.elapsed_times
            [2, 4, 4, 4, 5, 5, 7, 9]
          end

          def self.average
            5
          end

          def self.maximum
            7
          end

          def self.minimum
            3
          end

          def self.percent
            40.0
          end

          def self.value
            2
          end
        end
      end
    end
  end
end
