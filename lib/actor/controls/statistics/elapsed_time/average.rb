module Actor
  module Controls
    module Statistics
      module ElapsedTime
        module Average
          def self.configure_timer receiver
            ElapsedTime.configure_timer receiver, elapsed_times
          end

          def self.elapsed_times
            [1, 2, 6]
          end

          def self.value
            3
          end
        end
      end
    end
  end
end
