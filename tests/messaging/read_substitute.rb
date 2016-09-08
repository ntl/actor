require_relative '../test_init'

context "Inert substitute for read operation" do
  substitute_reader = Actor::Messaging::Read::Substitute.new

  context "No messages have been added" do
    context "Wait is not specified (default)" do
      message_read = substitute_reader.()

      test "Message is returned" do
        assert message_read == nil
      end
    end

    context "Wait is specified" do
      test "Error indicating operation would wait is raised" do
        assert proc { substitute_reader.(wait: true) } do
          raises_error? substitute_reader.class::WouldWait
        end
      end
    end
  end

  context "Messages have been added" do
    message = Controls::Message.example

    context "Wait is not specified (default)" do
      substitute_reader.add_message message

      message_read = substitute_reader.()

      test "Message is returned" do
        assert message_read == message
      end
    end

    context "Wait is specified" do
      substitute_reader.add_message message

      message_read = substitute_reader.(wait: true)

      test "Message is returned" do
        assert message_read == message
      end
    end
  end
end
