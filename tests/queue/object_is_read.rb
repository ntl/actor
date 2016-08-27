require_relative '../test_init'

context "Object is read from queue" do
  object = Object.new

  context "Queue is not empty" do
    queue = Queue.new
    queue.list << object
    queue.tail = 11
    queue.consumer_started

    test "Consumer reads enqueued object" do
      consumed_object = queue.read 11

      assert consumed_object == object
    end

    test "Reference count of previous position is decreased" do
      assert queue.consumer_positions[11] == 0
    end

    test "Reference count of next position is increased" do
      assert queue.consumer_positions[12] == 1
    end
  end

  context "Queue is empty" do
    context "Wait is not specified (default)" do
      queue = Queue.new
      queue.tail = 11
      queue.consumer_started

      test "Nothing is returned" do
        consumed_object = queue.read 11

        assert consumed_object == nil
      end

      test "Reference count of previous position is not decreased" do
        assert queue.consumer_positions[11] == 1
      end

      test "Reference count of next position is not increased" do
        assert queue.consumer_positions[12] == 0
      end
    end

    context "Wait is specified" do
      queue = Queue.new
      queue.tail = 11
      queue.consumer_started

      consumed_object = nil

      thread = Thread.new do
        Thread.current.abort_on_exception = true
        consumed_object = queue.read 11, wait: true
      end

      Thread.pass until thread.status == 'sleep'

      queue.write object

      thread.join

      assert consumed_object == object
    end
  end
end
