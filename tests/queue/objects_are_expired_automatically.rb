require_relative '../test_init'

context "Objects that have been read by all consumers are expired" do
  queue = Queue.new

  queue.consumer_started 0
  queue.consumer_started 3

  5.times { queue.write Object.new }

  context "Consumed object has yet to be read by all other consumers" do
    queue.read 3

    test "Object is not removed" do
      assert queue.size == 5
    end

    test "Tail is unchanged" do
      assert queue.tail == 0
    end
  end

  context "Consumed object has been read by all other consumers" do
    queue.read 0

    test "Object is removed" do
      assert queue.size == 4
    end

    test "Tail is incremented" do
      assert queue.tail == 1
    end
  end

  context "Consumer at tail of queue stops" do
    queue.consumer_stopped 1

    test "Tail is advanced to the next most delayed consumer" do
      assert queue.tail == 4
    end

    test "All objects up to new tail are removed" do
      assert queue.size == 1
    end
  end
end
