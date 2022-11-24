require_relative '../../test_init'

context "Supervisor Handles Actor Started Message" do
  context "No Error" do
    actor_started, actor = Controls::Message::ActorStarted.pair
    supervisor = Supervisor.new

    supervisor.handle actor_started

    test "Actor is registered with supervisor" do
      assert supervisor.registered_actor?(actor)
    end

    test "Actor count is increased" do
      assert supervisor.actor_count == 1
    end

    test "Actor isn't sent a stop message" do
      refute supervisor.send.sent?
    end
  end

  context "Error" do
    actor_started, actor = Controls::Message::ActorStarted.pair
    supervisor = Supervisor.new

    supervisor.error = Controls::Error.example

    supervisor.handle actor_started

    test "Actor is sent a stop message" do
      assert supervisor.send.sent?(Messages::Stop, address: actor.address)
    end

    test "Actor isn't registered with supervisor" do
      refute supervisor.registered_actor?(actor)
    end

    test "Actor count isn't increased" do
      assert supervisor.actor_count == 0
    end
  end
end
