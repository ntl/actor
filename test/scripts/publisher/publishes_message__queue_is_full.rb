require_relative '../scripts_init'

context "Publisher, Publishes Message to a Full Queue" do
  address = Address.build max_queue_size: 1

  publisher = Publisher.build address
  publisher.publish :some_message

  context "Wait is not specified" do
    blocked = false

    read_thread = Thread.new do
      Thread.pass until address.queue.num_waiting > 0
      blocked = true
      address.queue.deq
    end

    test "Thread is blocked until another thread writes to queue" do
      publisher.publish :some_message

      assert blocked
    end
  end

  context "Wait is disabled" do
    test "WouldBlockError is raised" do
      assert proc { publisher.publish :some_message, wait: false } do
        raises_error? Publisher::WouldBlockError
      end
    end
  end
end
