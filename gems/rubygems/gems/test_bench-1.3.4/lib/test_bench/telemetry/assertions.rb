module TestBench
  class Telemetry
    module Assertions
      def elapsed? seconds
        seconds == elapsed_time
      end

      def record_count &block
        sink.count do |record|
          block.(record)
        end
      end

      def recorded_any? control_event
        count = record_count do |record|
          record.event == control_event
        end

        count > 0
      end

      def recorded_asserted?
        recorded_any? :asserted
      end

      def recorded_comment?
        recorded_any? :commented
      end

      def recorded_context_entered?
        recorded_any? :context_entered
      end

      def recorded_context_exited?
        recorded_any? :context_exited
      end

      def recorded_error_raised?
        recorded_any? :error_raised
      end

      def recorded_file_finished?
        recorded_any? :file_finished
      end

      def recorded_file_started?
        recorded_any? :file_started
      end

      def recorded_run_finished?
        recorded_any? :run_finished
      end

      def recorded_run_started?
        recorded_any? :run_started
      end

      def recorded_test_failed?
        recorded_any? :test_failed
      end

      def recorded_test_finished?
        recorded_any? :test_finished
      end

      def recorded_test_passed?
        recorded_any? :test_passed
      end

      def recorded_test_skipped?
        recorded_any? :test_skipped
      end

      def recorded_test_started?
        recorded_any? :test_started
      end

      def test? prose
        record_count do |record|
          record.event == :test_started and record.data == prose
        end
      end
    end
  end
end
