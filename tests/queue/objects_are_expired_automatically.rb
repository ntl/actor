require_relative '../test_init'

context "Objects that have been read by all readers are expired" do
  queue = Actor::Queue.new

  queue.reader_started 0
  queue.reader_started 3

  5.times { queue.write Object.new }

  context "Object that is read has yet to be read by all other readers" do
    queue.read 3

    test "Object is not removed" do
      assert queue.size == 5
    end

    test "Tail is unchanged" do
      assert queue.tail == 0
    end
  end

  context "Object that is read has been read by all other readers" do
    queue.read 0

    test "Object is removed" do
      assert queue.size == 4
    end

    test "Tail is incremented" do
      assert queue.tail == 1
    end
  end

  context "Reader at tail of queue stops" do
    queue.reader_stopped 1

    test "Tail is advanced to the next most delayed reader" do
      assert queue.tail == 4
    end

    test "All objects up to new tail are removed" do
      assert queue.size == 1
    end
  end
end
