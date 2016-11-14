require_relative '../../test_init'

context "Actor Handles Suspend Message" do
  actor = Fixtures::Controls::Actor.example
  actor.suspend_queue = Messaging::Queue.get

  actor.handle Messages::Suspend

  test "Actor is suspended" do
    assert actor do
      suspended?
    end
  end

  context "Subsequent message is handled" do
    message = Fixtures::Controls::Message.example

    actor.handle message

    test "Message handling is deferred, and deferring will not block" do
      assert actor do
        message_deferred? message, wait: false
      end
    end

    test "Message handler is not invoked" do
      refute actor do
        handled? message
      end
    end
  end
end
