module Actor
  module Controls
    module Statistics
      module Timer
        def self.example elapsed_times=nil
          elapsed_times ||= [Controls::Time::ElapsedTime.example]

          steps = elapsed_times.flat_map do |elapsed_time|
            [elapsed_time, 0]
          end

          timer = ::Actor::Statistics::Timer.new
          timer.clock = Time::Clock.build steps
          timer
        end
      end
    end
  end
end
