require_relative '../test_init'

context "Reader starts reading a queue" do
  queue = Actor::Queue.new
  queue.tail = 11

  reader = Actor::Queue::Reader.build queue

  test "Position is set to tail of queue" do
    assert reader.position == 11
  end

  test "Reference count for the tail position is incremented" do
    assert queue.reader_positions[11] == 1
  end

  test "Reader indicates it has stopped" do
    refute reader.stopped?
  end

  test "Queue indicates there are readers present" do
    assert queue.readers?
  end
end
