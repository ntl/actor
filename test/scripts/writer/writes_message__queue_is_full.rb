require_relative '../scripts_init'

context "Writer, Writes Message to a Full Queue" do
  address = Address.build max_queue_size: 1

  writer = Writer.build address
  writer.write :some_message

  context "Wait is not specified" do
    blocked = false

    read_thread = Thread.new do
      Thread.pass until address.queue.num_waiting > 0
      blocked = true
      address.queue.deq
    end

    test "Thread is blocked until another thread writes to queue" do
      writer.write :some_message

      assert blocked
    end
  end

  context "Wait is disabled" do
    test "WouldBlockError is raised" do
      assert proc { writer.write :some_message, wait: false } do
        raises_error? Writer::WouldBlockError
      end
    end
  end
end
