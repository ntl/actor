module TestBench
  module Controls
    module Clock
      module Reference
        def self.now
          value
        end

        def self.value
          Time.new 2000, 1, 1, 1, 1, 1, 0
        end
      end
    end
  end
end
