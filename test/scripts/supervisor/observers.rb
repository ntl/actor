require_relative '../../test_init'

context "Supervisor Observers" do
  supervisor = Supervisor.new
  observer = Controls::SupervisorObserver.build supervisor

  context "Actor started message is sent to supervisor" do
    actor_started = Controls::Message::ActorStarted.example

    supervisor.handle actor_started

    test "Observer handles the message" do
      assert observer do
        handled? actor_started
      end
    end
  end

  context "Actor crashed message is sent to supervisor" do
    actor_crashed = Controls::Message::ActorCrashed.example

    supervisor.handle actor_crashed

    test "Observer handles the message" do
      assert observer do
        handled? actor_crashed
      end
    end
  end
end
