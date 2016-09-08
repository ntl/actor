require_relative '../test_init'

context "Reader reads a stream without any new messages" do
  address = Controls::Address.example

  read = Messaging::Read.build address

  context "Wait is not specified (default)" do
    message_read = read.()

    test "Nothing is returned" do
      assert message_read == nil
    end
  end

  context "Wait is specified" do
    message_read = nil

    thread = Thread.new do
      message_read = read.(wait: true)
    end

    message = Controls::Message.example
    Messaging::Write.(message, address)

    thread.join

    test "When message is eventually written, it is returned" do
      assert message_read == message
    end
  end
end
