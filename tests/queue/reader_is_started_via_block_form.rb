require_relative '../test_init'

context "Reader is started via block form" do
  queue = Queue.new
  queue.tail = 11

  context do
    reader = Queue::Reader.start queue do |reader|
      test "Position is set to tail of queue" do
        assert reader.position == 11
      end

      test "Reference count for the tail position is incremented" do
        assert queue.reader_positions[11] == 1
      end

      test "Reader does not indicate it is stopped within block" do
        refute reader.stopped?
      end
    end

    test "Reader indicates it stopped after block finishes" do
      assert reader.stopped?
    end

    test "Queue indicates there are no readers present after block finishes" do
      refute queue.readers?
    end
  end

  context "An error is raised within the block" do
    reader = nil

    begin
      Queue::Reader.start queue do |_reader|
        reader = _reader
        fail
      end
    rescue
    end

    test "Reader indicates it is stopped after block finishes" do
      assert reader.stopped?
    end

    test "Queue indicates there are no readers present after block finishes" do
      refute queue.readers?
    end
  end
end
