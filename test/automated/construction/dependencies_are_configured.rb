require_relative '../../test_init'

context "Actor Builder Configures Dependencies" do
  actor_cls = Controls::Actor.define

  actor = Actor::Build.(actor_cls)

  test "Queue is assigned" do
    assert actor.queue_configured?
  end

  test "Reader is configured with queue assigned to actor" do
    assert actor.reader_configured?

    assert actor.read.queue?(actor.queue)
  end

  test "Send is configured" do
    assert actor.send_configured?
  end
end
