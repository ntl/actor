require_relative '../test_init'

context "Reader reads a stream without any new messages" do
  address, queue = Controls::Address.pair
  reader = Messaging::Read.new queue, address.stream

  context "Wait is not specified (default)" do
    message_read = reader.()

    test "Nothing is returned" do
      assert message_read == nil
    end
  end

  context "Wait is specified" do
    message_read = nil

    thread = Thread.new do
      message_read = reader.(wait: true)
    end

    Thread.pass until queue.num_waiting > 0

    message = Controls::Message.example
    queue.enq message

    thread.join

    test "When message is eventually written, it is returned" do
      assert message_read == message
    end
  end
end
