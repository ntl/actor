require_relative '../test_init'

context "Message is available to read prior to run loop iteration" do
  message = Controls::Message.example

  context "Continuation stack is empty" do
    actor = Controls::Actor.example
    actor.reader.add_message message

    actor.next

    test "Message is read and handled" do
      assert actor do
        handled? message
      end
    end
  end

  context "Continuation stack is not empty" do
    message = Controls::Message.example

    context do
      actor = Controls::Actor.example
      actor.reader.add_message message
      actor.continuations << :continuation_message

      actor.next

      test "Message is read and handled" do
        assert actor do
          handled? message
        end
      end
    end

    context "Handler returns a message" do
      actor = Controls::Actor::Continues.new
      actor.reader.add_message message
      actor.continuations << :continuation_message

      actor.next

      test "Returned message is added to continuation stack" do
        other_message = Controls::Message::Other.example

        assert actor.continuations == [:continuation_message, other_message]
      end
    end

    context "Handler returns nothing" do
      actor = Controls::Actor.example
      actor.reader.add_message message
      actor.continuations << :continuation_message

      actor.next

      test "Continuation stack is unchanged" do
        assert actor.continuations == [:continuation_message]
      end
    end
  end
end
