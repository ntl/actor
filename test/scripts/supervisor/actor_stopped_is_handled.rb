require_relative '../../test_init'

context "Supervisor Handles Actor Stopped Message" do
  actor_stopped, actor = Controls::Message::ActorStopped.pair
  supervisor = Supervisor.new

  supervisor.handle actor_stopped

  test "Actor is unregistered with supervisor" do
    assert supervisor do
      unregistered_actor? actor
    end
  end

  test "Actor count is decreased" do
    assert supervisor.actor_count == -1
  end
end
