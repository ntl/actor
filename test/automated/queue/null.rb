require_relative '../../test_init'

context "Queue, Null" do
  queue = Messaging::Queue::Null.build

  test "Is substitute" do
    assert queue.instance_of?(Messaging::Queue::Substitute)
  end

  test "Queue depth is zero" do
    assert queue.size == 0
  end

  test "Queue limit is infinite" do
    assert queue.max == Float::INFINITY
  end
end
