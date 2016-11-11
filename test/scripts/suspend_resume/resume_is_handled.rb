require_relative '../../test_init'

context "Suspended Actor Handles Resume Message" do
  context do
    actor = Fixtures::Controls::Actor.example
    actor.suspend!

    actor.handle Messages::Resume

    test "Actor is no longer suspended" do
      refute actor do
        suspended?
      end
    end
  end

  context "Messages have been deferred while actor was suspended" do
    msg1 = Fixtures::Controls::Message.example
    msg2 = Fixtures::Controls::Message.example
    msg3 = Fixtures::Controls::Message.example

    actor = Fixtures::Controls::Actor.example
    actor.suspend!
    actor.defer_message msg1, msg2, msg3

    actor.handle Messages::Resume

    test "Actor sends itself all deferred messages" do
      assert actor.writer do
        written? msg1 and written? msg2 and written? msg3
      end
    end

    test "Messages are no longer deferred" do
      refute actor do
        message_deferred?
      end
    end
  end

  context "Subsequent message is handled" do
    message = Fixtures::Controls::Message.example

    actor = Fixtures::Controls::Actor.example
    actor.suspend!

    actor.handle Messages::Resume

    actor.handle message

    test "Message handler is invoked" do
      assert actor do
        handled? message
      end
    end
  end
end
