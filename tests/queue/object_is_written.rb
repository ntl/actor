require_relative '../test_init'

context "Object is written to queue" do
  object = Object.new

  context "Queue has no readers" do
    queue = Queue.new

    queue.write object

    test "Object is not written" do
      assert queue, &:empty?
    end
  end

  context "Queue has a reader" do
    queue = Queue.new
    queue.reader_started

    queue.write object

    test "Message is written" do
      assert queue do
        contains? object
      end
    end
  end
end
