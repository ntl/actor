require_relative '../../test_init'

context "Supervisor Handles Actor Stopped Message" do
  actor_stopped, actor = Fixtures::Controls::Message::ActorStopped.pair
  supervisor = Supervisor.new

  supervisor.handle actor_stopped

  test "Actor is unregistered with supervisor" do
    assert supervisor do
      unregistered_actor? actor
    end
  end
end
