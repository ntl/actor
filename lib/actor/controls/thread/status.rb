module Actor
  module Controls
    module Thread
      module Status
        def self.active
          'run'
        end

        def self.asleep
          'sleep'
        end

        def self.finished
          false
        end

        def self.crashed
          nil
        end
      end
    end
  end
end
