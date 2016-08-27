require_relative '../test_init'

context "Object is written to queue" do
  object = Object.new

  context "Queue has no consumers" do
    queue = Queue.new

    queue.write object

    test "Message is not recorded" do
      assert queue, &:empty?
    end
  end

  context "Queue has a consumer" do
    queue = Queue.new
    queue.consumer_started

    queue.write object

    test "Message is recorded" do
      assert queue do
        contains? object
      end
    end
  end
end
