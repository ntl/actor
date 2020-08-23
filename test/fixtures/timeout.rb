module Fixtures
  class Timeout
    include TestBench::Fixture

    attr_reader :block
    attr_reader :prose
    attr_reader :duration_milliseconds
    attr_reader :poll_interval_milliseconds

    def initialize(block, prose, duration_milliseconds, poll_interval_milliseconds)
      @block, @prose, @duration_milliseconds, @poll_interval_milliseconds = block, prose, duration_milliseconds, poll_interval_milliseconds
    end

    def self.call(prose=nil, duration: nil, poll_interval: nil, &block)
      prose ||= "Condition is met"
      duration ||= Defaults.duration_milliseconds
      poll_interval ||= Defaults.poll_interval_milliseconds
      block ||= proc { sleep }

      instance = new(block, prose, duration, poll_interval)
      instance.()
    end

    def call
      test prose do
        condition_met = await(&block)

        assert(condition_met)
      end
    end

    def await(&condition)
      t0 = Time.now
      t1 = t0

      duration_seconds = duration_milliseconds / 1_000.0
      poll_interval_seconds = poll_interval_milliseconds / 1_000.0

      loop do
        condition_met = condition.()

        return true if condition_met

        t2 = Time.now

        elapsed_time = t2 - t0
        if elapsed_time > duration_seconds
          return false
        end

        cycle_elapsed_time = t2 - t1

        sleep_duration = poll_interval_seconds - cycle_elapsed_time

        t1 = t2

        sleep(sleep_duration) unless sleep_duration < 0
      end
    end

    module Defaults
      def self.duration_milliseconds
        10
      end

      def self.poll_interval_milliseconds
        1
      end
    end
  end
end
