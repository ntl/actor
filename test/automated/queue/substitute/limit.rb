require_relative '../../../test_init'

context "Queue Substitute, Limit" do
  substitute = Messaging::Queue::Substitute.build

  test "Value is infinite" do
    assert substitute.max == Float::INFINITY
  end
end
