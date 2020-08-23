require_relative '../../../test_init'

context "Queue Substitute, Depth" do
  substitute = Messaging::Queue::Substitute.build

  test "Value is zero" do
    assert substitute.size == 0
  end

  context "Value is set" do
    substitute.size = 11

    test "Specified value is returned" do
      assert substitute.size == 11
    end
  end
end
