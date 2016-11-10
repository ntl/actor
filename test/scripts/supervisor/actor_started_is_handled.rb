require_relative '../../test_init'

context "Supervisor Handles Actor Started Message" do
  actor_started, actor = Fixtures::Controls::Message::ActorStarted.pair
  supervisor = Supervisor.new

  supervisor.handle actor_started

  test "Actor is registered with supervisor" do
    assert supervisor do
      registered_actor? actor
    end
  end
end
