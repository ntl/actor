require_relative '../test_init'

context "No message is available to read prior to run loop iteration" do
  context "Continuation stack is empty" do
    actor = Controls::Actor.example

    test "Thread is blocked until a message becomes available" do
      assert proc { actor.next } do
        raises_error? Messaging::Read::Substitute::WouldWait
      end
    end
  end

  context "Continuation stack is not empty" do
    message = Controls::Message.example

    context do
      actor = Controls::Actor.example
      actor.continuations << message

      actor.next

      test "Message is handled" do
        assert actor do
          handled? message
        end
      end
    end

    context "Handler returns a message" do
      actor = Controls::Actor::Continues.new
      actor.continuations << message

      actor.next

      test "Previous continuation message is replaced with message returned by handler" do
        other_message = Controls::Message::Other.example

        assert actor.continuations == [other_message]
      end
    end

    context "Handler returns nothing" do
      actor = Controls::Actor.example
      actor.continuations << message

      actor.next

      test "Continuation is removed from continuation stack" do
        assert actor.continuations == []
      end
    end
  end
end
