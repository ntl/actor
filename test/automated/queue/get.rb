require_relative '../../test_init'

context "Queue, Get" do
  queue = Messaging::Queue.get

  test "Returns SizedQueue" do
    assert queue.instance_of?(SizedQueue)
  end

  test "Limit" do
    assert queue.max == Messaging::Queue::Defaults.maximum_size
  end
end
