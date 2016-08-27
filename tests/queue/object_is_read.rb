require_relative '../test_init'

context "Object is read from queue" do
  object = Object.new

  context "Queue is not empty" do
    queue = Queue.new
    queue.list << object
    queue.tail = 11
    queue.reader_started

    test "Reader reads enqueued object" do
      read_object = queue.read 11

      assert read_object == object
    end

    test "Reference count of previous reader position is decreased" do
      assert queue.reader_positions[11] == 0
    end

    test "Reference count of next reader position is increased" do
      assert queue.reader_positions[12] == 1
    end
  end

  context "Queue is empty" do
    context "Wait is not requested (default)" do
      queue = Queue.new
      queue.tail = 11
      queue.reader_started

      test "Nothing is returned" do
        read_object = queue.read 11

        assert read_object == nil
      end

      test "Reference count of previous reader position is not decreased" do
        assert queue.reader_positions[11] == 1
      end

      test "Reference count of next reader position is not increased" do
        assert queue.reader_positions[12] == 0
      end
    end

    context "Wait is requested" do
      queue = Queue.new
      queue.tail = 11
      queue.reader_started

      read_object = nil

      thread = Thread.new do
        Thread.current.abort_on_exception = true
        read_object = queue.read 11, wait: true
      end

      Thread.pass until thread.status == 'sleep'

      queue.write object

      thread.join

      assert read_object == object
    end
  end
end
