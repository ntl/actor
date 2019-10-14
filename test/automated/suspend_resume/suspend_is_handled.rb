require_relative '../../test_init'

context "Actor Handles Suspend Message" do
  actor = Controls::Actor.example
  actor.suspend_queue = Messaging::Queue.get

  actor.handle Messages::Suspend

  test "Actor is suspended" do
    assert actor.suspended?
  end

  context "Subsequent message is handled" do
    message = Controls::Message.example

    actor.handle message

    test "Message handling is deferred, and deferring will not block" do
      assert actor.message_deferred?(message, wait: false)
    end

    test "Message handler is not invoked" do
      refute actor.handled?(message)
    end
  end
end
