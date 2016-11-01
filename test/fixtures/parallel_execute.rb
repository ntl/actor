module Fixtures
  class ParallelExecute
    include TestBench::Fixture

    attr_reader :action
    attr_reader :duration
    attr_reader :setup
    attr_reader :test
    attr_reader :thread_count

    def initialize action, test, setup, duration, thread_count
      @action = action
      @duration = duration
      @setup = setup
      @test = test
      @thread_count = thread_count
    end

    def self.call action:, test: nil, setup: nil
      test ||= proc { }
      setup ||= proc { }

      thread_count = Defaults.thread_count
      duration_milliseconds = Defaults.duration_milliseconds
      duration = Rational duration_milliseconds, 1000

      instance = new action, test, setup, duration, thread_count
      instance.()
    end

    def call
      thread_iterations = {}

      setup.(duration, thread_count)

      t0 = Time.now

      threads = thread_count.times.map do |thread_number|
        thread_iterations[thread_number] = 0

        thread = Thread.new do
          thread_iteration = 0

          loop do
            global_iteration = thread_count * thread_iteration + thread_number

            cycle = Cycle.new thread_iteration, global_iteration, thread_number
            action.(cycle)

            thread_iteration += 1

            break if (Time.now - t0) > duration

            Thread.pass if RUBY_ENGINE == 'ruby'
          end

          thread_iterations[thread_number] = thread_iteration
        end
      end

      threads.map &:join

      t1 = Time.now

      elapsed_time = t1 - t0

      iterations = thread_iterations.values.reduce &:+
      ips = Rational(iterations, elapsed_time)
      ips /= thread_count

      comment "ElapsedTime: #{(elapsed_time * 1000).round 2}ms, Iterations: #{iterations}, ThreadCount: #{thread_count}"
      comment "Iterations per second (per thread): #{ips.to_f.round 2}"

      test.(iterations, thread_iterations)
    end

    Cycle = Struct.new :thread_iteration, :global_iteration, :thread

    module Defaults
      def self.duration_milliseconds
        duration_milliseconds = ENV['DURATION_MILLISECONDS']

        return duration_milliseconds.to_i if duration_milliseconds

        100
      end

      def self.thread_count
        thread_count = ENV['THREAD_COUNT']

        return thread_count.to_i if thread_count

        4
      end
    end
  end
end
