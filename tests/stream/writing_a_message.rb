require_relative '../test_init'

context "Writing a message to a stream" do
  stream = Stream.new
  message = Controls::Message.example

  context "Stream is not being read" do
    stream.write message

    test "Message is not written to any queue" do
      assert stream.queues do
        all? { |queue| empty? }
      end
    end
  end

  context "Stream is being read by several readers" do
    queue_1 = Queue.new
    queue_2 = Queue.new

    stream.queues << queue_1
    stream.queues << queue_2

    stream.write message

    test "Message is written to each queue once" do
      assert queue_1.deq == message
      assert queue_2.deq == message

      assert queue_1.empty?
      assert queue_2.empty?
    end
  end
end
