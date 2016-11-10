require_relative '../scripts_init'

context "Actor Builder Configures Dependencies" do
  actor_cls = Class.new do
    include Actor
  end

  actor = Actor::Build.(actor_cls)

  test "Address is assigned" do
    assert actor, &:address_configured?
  end

  test "Reader is configured with address assigned to actor" do
    assert actor, &:reader_configured?

    assert actor.reader do
      address? actor.address
    end
  end

  test "Writer is configured" do
    assert actor, &:writer_configured?
  end
end