require_relative '../test_init'

context "Error is raised, causing actor to crash" do
  _, actor, thread = Controls::Actor::CrashesImmediately.start include: %i(actor thread)

  test "Error is reraised when thread is joined" do
    assert proc { thread.join } do
      raises_error? Controls::Actor::CrashesImmediately::Error
    end
  end

  test "Actor state is set to crashed" do
    assert actor.actor_state == :crashed
  end
end
