require_relative '../../../test_init'

context "Queue Substitute, Max" do
  substitute = Messaging::Queue::Substitute.build

  test "Value is infinite" do
    assert substitute.max == Float::INFINITY
  end
end
