require_relative '../test_init'

context "Actor is instantiated instead of started" do
  actor = Controls::Actor::Example.new

  test "Reader is a substitute" do
    assert actor.reader.instance_of? Messaging::Read::Substitute
  end

  test "Writer is a substitute" do
    assert actor.writer.instance_of? Messaging::Write::Substitute
  end
end
