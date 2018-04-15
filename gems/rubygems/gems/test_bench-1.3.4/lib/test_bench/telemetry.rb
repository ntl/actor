module TestBench
  class Telemetry
    include Observable

    attr_accessor :failed
    attr_writer :nesting
    attr_writer :sink

    def self.build
      instance = new

      if Settings.toplevel.record_telemetry
        instance.sink = []
      end

      instance
    end

    def asserted
      publish :asserted
    end

    def commented prose
      publish :commented, prose
    end

    def context_entered prose
      publish :context_entered, prose

      self.nesting += 1
    end

    def context_exited prose
      publish :context_exited, prose

      self.nesting -= 1

      nesting
    end

    def error_raised error
      self.failed = true

      publish :error_raised, error
    end

    def failed?
      if failed then true else false end
    end

    def file_finished file
      publish :file_finished, file
    end

    def file_started file
      publish :file_started, file
    end

    def nesting
      @nesting ||= 0
    end

    def passed?
      not failed?
    end

    def publish event, *arguments
      changed
      notify_observers event, *arguments

      record = Record.new event, *arguments
      sink << record
    end

    def run_started
      publish :run_started
    end

    def run_finished
      publish :run_finished
    end

    def sink
      @sink ||= NullSink
    end

    def subscribe subscriber
      subscription = Subscription.new subscriber
      add_observer subscription
      subscription
    end

    def test_failed prose
      publish :test_failed, prose
    end

    def test_finished prose
      publish :test_finished, prose
    end

    def test_passed prose
      publish :test_passed, prose
    end

    def test_skipped prose
      publish :test_skipped, prose
    end

    def test_started prose
      publish :test_started, prose
    end

    def self.subscribe subscriber
      toplevel_telemetry = Registry.get TOPLEVEL_BINDING
      toplevel_telemetry.subscribe subscriber
    end

    Record = Struct.new :event, :data

    module NullSink
      extend Enumerable

      def self.<< event
      end

      def self.each &block
      end
    end
  end
end
