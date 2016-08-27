module Actor
  module TestFixtures
    class ParallelIteration
      include TestBench::Fixture

      attr_writer :iteration_count
      attr_reader :iteration_proc
      attr_writer :setup_proc
      attr_writer :setup_thread_proc
      attr_writer :teardown_proc
      attr_accessor :test_proc
      attr_reader :prose
      attr_writer :thread_count

      def initialize iteration_proc, prose
        @iteration_proc = iteration_proc
        @prose = prose
      end

      def self.build prose, each_iteration:, test: nil, setup: nil, setup_thread: nil, teardown: nil, iterations: nil, threads: nil
        instance = new each_iteration, prose
        instance.iteration_count = iterations
        instance.setup_proc = setup
        instance.setup_thread_proc = setup_thread
        instance.teardown_proc = teardown
        instance.test_proc = test
        instance.thread_count = threads
        instance
      end

      def self.call *arguments
        instance = build *arguments
        instance.()
      end

      def call
        instance_exec &setup_proc

        threads = thread_count.times.map do |index|
          thread = Thread.new do
            Thread.stop

            instance_exec &setup_thread_proc

            iteration_count.times do
              instance_exec &iteration_proc
            end

            prose = "#{self.prose} (Thread: #{index + 1}/#{thread_count})"

            if test_proc
              test prose do
                instance_exec &test_proc
              end
            else
              context prose
            end
          end
          thread.abort_on_exception = true
          thread
        end

        Thread.pass until threads.all? &:stop?

        context "Started #{thread_count} threads; each will iterate #{iteration_count} times"

        t0 = Time.now

        threads.each &:wakeup
        threads.each &:join

        t1 = Time.now

        elapsed_time = t1 - t0

        total_iterations = thread_count * iteration_count

        iterations_per_second = Rational total_iterations, elapsed_time

        context "Finished %i iterations across %i threads in %.2fs; %.2f iterations per second" %
          [total_iterations, thread_count, elapsed_time, iterations_per_second]

        return iteration_count, thread_count

      ensure
        instance_exec &teardown_proc
      end

      def iteration_count
        @iteration_count ||= Defaults.iteration_count
      end

      def print_debug receiver
        str = receiver.inspect
        str << "\n"

        $stdout.write str
      end

      def setup_proc
        @setup_proc ||= proc {}
      end

      def setup_thread_proc
        @setup_thread_proc ||= proc {}
      end

      def teardown_proc
        @teardown_proc ||= proc {}
      end

      def thread
        Thread.current
      end

      def thread_count
        @thread_count ||= Defaults.thread_count
      end

      module Defaults
        def self.iteration_count
          if ENV['STRESS_TEST'] == 'high'
            10_000
          elsif ENV['STRESS_TEST'] == 'low'
            2_500
          else
            100
          end
        end

        def self.thread_count
          if ENV['STRESS_TEST'] == 'high'
            100
          elsif ENV['STRESS_TEST'] == 'low'
            25
          else
            2
          end
        end
      end
    end
  end
end
