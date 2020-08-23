require_relative '../../../test_init'

context "Queue Substitute, Size" do
  substitute = Messaging::Queue::Substitute.build

  test "Value is zero" do
    assert substitute.size == 0
  end
end
