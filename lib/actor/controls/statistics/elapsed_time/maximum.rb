module Actor
  module Controls
    module Statistics
      module ElapsedTime
        module Maximum
          def self.configure_timer receiver
            ElapsedTime.configure_timer receiver, elapsed_times
          end

          def self.elapsed_times
            [1, 11, 111]
          end

          def self.value
            111
          end
        end
      end
    end
  end
end
