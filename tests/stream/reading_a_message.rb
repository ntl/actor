require_relative '../test_init'

context "Reading a message that has been written to a stream" do
  stream = Stream.new
  message = Controls::Message.example

  queue = Queue.new

  stream.queues << queue

  stream.write message

  test do
    assert queue.deq == message
  end
end
