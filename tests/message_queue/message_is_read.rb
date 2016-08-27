require_relative '../test_init'

context "Message is read" do
  context "Message is available to be read" do
    queue = MessageQueue.new
    queue.list << 'some-message'
    queue.tail = 11
    queue.consumer_started

    test "Consumer reads message" do
      message = queue.read 11

      assert message == 'some-message'
    end

    test "Reference count of previous position is decreased" do
      assert queue.consumer_positions[11] == 0
    end

    test "Reference count of next position is increased" do
      assert queue.consumer_positions[12] == 1
    end
  end

  context "No message is available to be read" do
    context "Non-blocking read (default)" do
      queue = MessageQueue.new
      queue.tail = 11
      queue.consumer_started

      test "Nothing is returned" do
        message = queue.read 11

        assert message == nil
      end

      test "Reference count of previous position is not decreased" do
        assert queue.consumer_positions[11] == 1
      end

      test "Reference count of next position is not increased" do
        assert queue.consumer_positions[12] == 0
      end
    end

    context "Blocking read" do
      queue = MessageQueue.new
      queue.tail = 11
      queue.consumer_started

      message = nil

      thread = Thread.new do
        Thread.current.abort_on_exception = true
        message = queue.read 11, block: true
      end

      Thread.pass until thread.status == 'sleep'

      queue.write 'some-message'

      thread.join

      assert message == 'some-message'
    end
  end
end
