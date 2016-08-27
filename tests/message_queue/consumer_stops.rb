require_relative '../test_init'

context "Consumer stops consuming a queue" do
  queue = MessageQueue.new
  queue.tail = 11

  consumer = MessageQueue::Consumer.build queue

  consumer.stop

  test "Reference count for the tail position is decremented" do
    assert queue.consumer_positions[11] == 0
  end

  test "Consumers predicate returns false" do
    refute queue.consumers?
  end
end
