require_relative '../../test_init'

context "Send, Sends Message But Queue Is Full" do
  address = Messaging::Address.build max_queue_size: 1

  send = Messaging::Send.new
  send.(:insignificant_message, address)

  context "Wait is not specified" do
    blocked = false

    read_thread = Thread.new do
      Thread.pass until address.queue.num_waiting > 0
      blocked = true
      address.queue.deq
    end

    test "Thread is blocked until another thread sends a message to queue" do
      send.(:some_message, address)

      assert blocked
    end

    read_thread.join
  end

  context "Wait is disabled" do
    test "WouldBlockError is raised" do
      assert proc { send.(:some_message, address, wait: false) } do
        raises_error? Messaging::Send::WouldBlockError
      end
    end
  end
end
