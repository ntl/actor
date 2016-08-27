require_relative '../test_init'

context "Consumer starts consuming a queue" do
  queue = MessageQueue.new
  queue.tail = 11

  consumer = MessageQueue::Consumer.build queue

  test "osition is set to tail of queue" do
    assert consumer.position == 11
  end

  test "Reference count for the tail position is incremented" do
    assert queue.consumer_positions[11] == 1
  end

  test "Consumers predicate returns true" do
    assert queue.consumers?
  end
end
