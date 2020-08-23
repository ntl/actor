require_relative '../../test_init'

context "Send, Sends Message But Queue Is Full" do
  queue = Messaging::Queue.get max_size: 1

  send = Messaging::Send.new
  send.(:insignificant_message, queue)

  [["Wait is not specified", nil], ["Wait is disabled", false]].each do |prose, wait|
    context prose do
      test "QueueFullError is raised" do
        assert_raises Messaging::Send::QueueFullError do
          send.(:some_message, queue, wait: wait)
        end
      end
    end
  end

  context "Wait is enabled" do
    mutex = Mutex.new

    queue = queue

    read_thread = Thread.new do
      Thread.pass until queue.num_waiting > 0
      mutex.lock
      queue.deq
      sleep
    end

    test "Thread is blocked until another thread sends a message to queue" do
      send.(:some_message, queue, wait: true)

      assert mutex.locked?
    end

    read_thread.kill
  end
end
