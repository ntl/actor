require_relative '../test_init'

context "Continue message is handled by a supervisor" do
  continue = Supervisor::Continue.new

  context "No actor threads are currently running" do
    supervisor = Supervisor.new

    return_value = supervisor.handle continue

    test "Stop message is returned" do
      assert return_value.instance_of? Messages::Stop
    end
  end

  context "At least one actor thread is currently running" do
    supervisor = Supervisor.new
    actor_thread = Controls::Thread.example

    supervisor.thread_group.add actor_thread

    test "Stop iteration exception is not raised" do
      refute proc { supervisor.handle continue } do
        raises_error? StopIteration
      end
    end
  end
end
