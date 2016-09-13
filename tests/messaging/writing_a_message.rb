require_relative '../test_init'

context "Writer writes a message to an address" do
  message = Controls::Message.example

  context do
    writer = Messaging::Write.new

    address, queue = Controls::Address.pair

    return_value = writer.(message, address)

    test "Message is written to address" do
      assert queue.deq == message
    end

    test "Nothing is returned" do
      assert return_value == nil
    end
  end

  context "Class interface" do
    address, queue = Controls::Address.pair

    Messaging::Write.(message, address)

    test "Message is written to address" do
      assert queue.deq == message
    end
  end
end
