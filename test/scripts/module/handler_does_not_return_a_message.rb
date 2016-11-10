require_relative '../../test_init'

context "Actor Handles a Message, Handler Does Not Return a Message" do
  message = Fixtures::Controls::Message.example

  actor = Fixtures::Controls::Actor.define_singleton do
    handle message do
      Object.new
    end
  end

  actor.handle message

  test "Nothing is written" do
    refute actor.writer do
      written?
    end
  end
end
