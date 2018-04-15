module TestBench
  module Controls
    module TestScript
      module Failing
        def self.example
          'assert false'
        end
      end

      module Passing
        def self.example
          'assert true'
        end
      end

      module Error
        def self.example
          'fail'
        end
      end
    end
  end
end
