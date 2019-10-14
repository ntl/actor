require_relative '../../test_init'

context "Supervisor Handles Actor Started Message" do
  actor_started, actor = Controls::Message::ActorStarted.pair
  supervisor = Supervisor.new

  supervisor.handle actor_started

  test "Actor is registered with supervisor" do
    assert supervisor.registered_actor?(actor)
  end

  test "Actor count is increased" do
    assert supervisor.actor_count == 1
  end
end
