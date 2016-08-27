require_relative '../test_init'

context "Message is written to queue" do
  context "Queue has no consumers" do
    queue = Queue.new

    queue.write 'some-message'

    test "Message is not recorded" do
      assert queue, &:empty?
    end
  end

  context "Queue has a consumer" do
    queue = Queue.new
    queue.consumer_started

    queue.write 'some-message'

    test "Message is recorded" do
      assert queue do
        contains? 'some-message'
      end
    end
  end
end
