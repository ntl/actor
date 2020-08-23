require_relative '../../test_init'

context "Send, Sends Message But Queue Is Full" do
  address = Messaging::Address.build max_queue_size: 1

  send = Messaging::Send.new
  send.(:insignificant_message, address)

  [["Wait is not specified", nil], ["Wait is disabled", false]].each do |prose, wait|
    context prose do
      test "QueueFullError is raised" do
        assert_raises Messaging::Send::QueueFullError do
          send.(:some_message, address, wait: wait)
        end
      end
    end
  end

  context "Wait is enabled" do
    mutex = Mutex.new

    queue = address.queue

    read_thread = Thread.new do
      Thread.pass until queue.num_waiting > 0
      mutex.lock
      queue.deq
      sleep
    end

    test "Thread is blocked until another thread sends a message to queue" do
      send.(:some_message, address, wait: true)

      assert mutex.locked?
    end

    read_thread.kill
  end
end
