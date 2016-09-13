require_relative '../test_init'

context "Actor run loop iterates once" do
  actor = Controls::Actor.example

  context "No message is ready to be read" do
    test "Thread is blocked until a message is delivered" do
      assert proc { actor.next } do
        raises_error? Messaging::Read::Substitute::WouldWait
      end
    end
  end

  context "Message is ready to be read" do
    actor = Controls::Actor.example

    message = Controls::Message.example
    actor.reader.add_message message

    actor.next

    test "Message is read and handled" do
      assert actor do handled? message end
    end
  end
end
