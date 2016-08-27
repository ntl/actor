require_relative '../test_init'

context "Messages that have been read by all consumers are expired" do
  queue = Queue.new

  queue.consumer_started 0
  queue.consumer_started 3

  queue.write 'message-0'
  queue.write 'message-1'
  queue.write 'message-2'
  queue.write 'message-3'
  queue.write 'message-4'

  context "Consumer reads message that has yet to be read by other consumers" do
    queue.read 3

    test "Message is not removed" do
      assert queue.size == 5
    end

    test "Tail is unchanged" do
      assert queue.tail == 0
    end
  end

  context "Consumer reads message that has been read by all other consumers" do
    queue.read 0

    test "Message is removed" do
      assert queue.size == 4
    end

    test "Tail is incremented" do
      assert queue.tail == 1
    end
  end

  context "Consumer furthest behind stops" do
    queue.consumer_stopped 1

    test "All messages up to next furthest behind consumer are removed" do
      assert queue.size == 1
    end

    test "Tail is advanced to the next furthest behind consumer" do
      assert queue.tail == 4
    end
  end
end
