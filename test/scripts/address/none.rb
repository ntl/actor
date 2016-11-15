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
end
