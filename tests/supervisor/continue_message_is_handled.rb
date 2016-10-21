require_relative '../test_init'

context "Continue message is handled by a supervisor" do
  context "No actor threads are currently running" do
    context "No actors have crashed" do
      supervisor = Supervisor.new

      return_value = supervisor.handle :continue

      test "Stop message is returned" do
        assert return_value == :stop
      end
    end

    context "An actor has crashed" do
      supervisor = Supervisor.new
      supervisor.error = Controls::Error.example

      test "Error is reraised" do
        assert proc { supervisor.handle :continue } do
          raises_error? Controls::Error::Example
        end
      end
    end
  end

  context "At least one actor thread is currently running" do
    supervisor = Supervisor.new
    actor_thread = Controls::Thread.example

    supervisor.thread_group.add actor_thread

    test "Stop iteration exception is not raised" do
      refute proc { supervisor.handle :continue } do
        raises_error? StopIteration
      end
    end
  end
end
