module Actor
  module Substitutes
    class Kernel
      def initialize
        @sleep_duration = nil
      end

      def sleep duration=nil
        @sleep_duration = duration
      end

      module Assertions
        def slept? duration=nil
          if duration.nil?
            @sleep_duration ? true : false
          else
            @sleep_duration == duration
          end
        end
      end
    end
  end
end
