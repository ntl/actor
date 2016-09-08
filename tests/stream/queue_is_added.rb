require_relative '../test_init'

context "Queue is added to stream" do
  stream = Stream.new
  queue = Queue.new

  stream.add_queue queue

  test do
    assert stream.queues do
      include? queue
    end
  end
end
