require_relative '../../test_init'

context "Address, None Singleton" do
  none = Messaging::Address::None.build

  test "ID is none" do
    assert none.id == '(none)'
  end

  test "Queue attribute is substitute" do
    assert none.queue do
      instance_of? Messaging::Queue::Substitute
    end
  end

  test "Queue depth is zero" do
    assert none.queue_depth == 0
  end

  test "Queue limit is infinite" do
    assert none.queue_limit == Float::INFINITY
  end
end
