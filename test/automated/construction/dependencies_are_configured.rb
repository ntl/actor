require_relative '../../test_init'

context "Actor Builder Configures Dependencies" do
  actor_cls = Controls::Actor.define

  actor = Actor::Build.(actor_cls)

  test "Address is assigned" do
    assert actor.address_configured?
  end

  test "Reader is configured with address assigned to actor" do
    assert actor.reader_configured?

    assert actor.read.address?(actor.address)
  end

  test "Send is configured" do
    assert actor.send_configured?
  end
end
