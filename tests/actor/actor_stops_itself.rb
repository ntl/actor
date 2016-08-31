require_relative '../test_init'

context "Actor stops itself" do
  _, actor, thread = Controls::Actor::StopsImmediately.start include: %i(actor thread)

  thread.join

  test "State is stopped" do
    assert actor.actor_state == :stopped
  end
end
