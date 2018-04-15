module TestBench
  module Controls
    module Clock
      class Elapsed
        def self.example
          new t0, t1
        end

        def self.seconds
          61.11111
        end

        def self.t0
          time = Time.new 2000, 1, 1, 1, 1, 1.11111, 0
          time.round 5
        end

        def self.t1
          time = Time.new 2000, 1, 1, 1, 2, 2.22222, 0
          time.round 5
        end

        attr_reader :t0
        attr_reader :t1

        def initialize t0, t1
          @t0 = t0
          @t1 = t1
        end

        def now
          enumerator.next
        end

        def enumerator
          @enumerator ||= [t0, t1].lazy
        end
      end
    end
  end
end
