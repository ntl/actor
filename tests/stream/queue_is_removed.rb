require_relative '../test_init'

context "Queue is removed from stream" do
  stream = Stream.new
  queue = Queue.new

  stream.queues << queue

  stream.remove_queue queue

  test do
    refute stream.queues do
      include? queue
    end
  end
end
