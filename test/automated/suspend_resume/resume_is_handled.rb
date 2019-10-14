require_relative '../../test_init'

context "Suspended Actor Handles Resume Message" do
  context do
    actor = Controls::Actor.example
    actor.suspend!

    actor.handle Messages::Resume

    test "Actor is no longer suspended" do
      refute actor.suspended?
    end
  end

  context "Messages have been deferred while actor was suspended" do
    msg1 = Controls::Message.example
    msg2 = Controls::Message.example
    msg3 = Controls::Message.example

    actor = Controls::Actor.example
    actor.suspend_queue = Messaging::Queue.get
    actor.suspend!
    actor.defer_message msg1, msg2, msg3

    actor.handle Messages::Resume

    test "Actor sends itself all deferred messages" do
      assert(actor.send.sent?(msg1))
      assert(actor.send.sent?(msg2))
      assert(actor.send.sent?(msg3))
    end

    test "Messages are no longer deferred" do
      refute actor.message_deferred?
    end
  end

  context "Subsequent message is handled" do
    message = Controls::Message.example

    actor = Controls::Actor.example
    actor.suspend!

    actor.handle Messages::Resume

    actor.handle message

    test "Message handler is invoked" do
      assert actor.handled?(message)
    end
  end
end
