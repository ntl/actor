require_relative '../test_init'

context "Reader stops reading a queue" do
  queue = Queue.new
  queue.tail = 11

  reader = Queue::Reader.build queue

  reader.stop

  test "Reference count for the tail position is decremented" do
    assert queue.reader_positions[11] == 0
  end

  test "Reader indicates it has stopped" do
    assert reader.stopped?
  end

  test "Queue indicates there are no readers present" do
    refute queue.readers?
  end

  test "Subsequent reads fail immediately" do
    assert proc { reader.next } do
      raises_error? Queue::Reader::Stopped
    end
  end
end
