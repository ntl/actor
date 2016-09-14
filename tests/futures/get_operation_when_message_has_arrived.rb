require_relative '../test_init'

context "Get operation of a future when message has arrived" do
  message = Controls::Message.example

  reader = Messaging::Read::Substitute.new
  reader.add_message message

  future = Future.new reader

  context "Wait is not specfied" do
    message_read = future.get

    test "Message is returned" do
      assert message_read == message
    end
  end

  context "Wait is specified" do
    message_read = future.get wait: true

    test "Message is returned" do
      assert message_read == message
    end
  end
end
