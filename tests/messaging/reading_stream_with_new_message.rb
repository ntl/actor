require_relative '../test_init'

context "Reader reads a stream with new messages" do
  message = Controls::Message.example
  address = Controls::Address.example

  context "Wait is not specified (default)" do
    reader = Messaging::Read.build address

    Messaging::Write.(message, address)

    message_read = reader.()

    test "Message is returned" do
      assert message_read == message
    end
  end

  context "Wait is specified" do
    reader = Messaging::Read.build address

    Messaging::Write.(message, address)

    message_read = reader.(wait: true)

    test "Message is returned" do
      assert message_read == message
    end
  end

  test "No messages are available" do
    reader = Messaging::Read.build address

    Messaging::Write.(message, address)

    assert reader.messages_available?
  end
end
