require_relative '../../test_init'

context "Supervisor Handles Actor Crashed Message" do
  actor_crashed = Controls::Message::ActorCrashed.example

  context do
    supervisor = Supervisor.new
    supervisor.handle actor_crashed

    test "Error is set" do
      assert supervisor.error == Controls::Error.example
    end

    test "Supervisor sends itself the shutdown message" do
      assert supervisor.writer do
        written? Messages::Shutdown, address: supervisor.address
      end
    end
  end

  context "Error is already set" do
    supervisor = Supervisor.new
    supervisor.error = previous_error = RuntimeError.new

    supervisor.handle actor_crashed

    test "Error is not changed" do
      assert supervisor.error == previous_error
    end
  end
end
