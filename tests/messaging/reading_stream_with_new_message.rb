require_relative '../test_init'

context "Reader reads a stream with new messages" do
  message = Controls::Message.example

  context "Wait is not specified (default)" do
    address = Controls::Address.example
    read = Messaging::Read.build address

    Messaging::Write.(message, address)

    message_read = read.()

    test "Message is returned" do
      assert message_read == message
    end
  end

  context "Wait is specified" do
    address = Controls::Address.example
    read = Messaging::Read.build address

    Messaging::Write.(message, address)

    message_read = read.(wait: true)

    test "Message is returned" do
      assert message_read == message
    end
  end
end
