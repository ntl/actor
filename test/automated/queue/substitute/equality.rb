require_relative '../../../test_init'

context "Queue Substitute, Equality" do
  substitute = Messaging::Queue::Substitute.build

  context "Substitute is compared against itself" do
    test "Instances are equal" do
      assert substitute == substitute
    end
  end

  context "Queue is compared against another substitute" do
    test "Instances are not equal" do
      refute substitute == Messaging::Queue::Substitute.build
    end
  end
end
