module Actor
  module Controls
    module Statistics
      module ElapsedTime
        def self.configure_timer receiver, elapsed_times
          timer = Timer.example elapsed_times

          receiver.timer = timer

          elapsed_times.count
        end
      end
    end
  end
end
