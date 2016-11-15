require_relative '../../test_init'

context "Address, Substitute" do
  substitute = Messaging::Address::Substitute.build

  test "ID is none" do
    assert substitute.id == '(none)'
  end

  test "Queue attribute is substitute" do
    assert substitute.queue do
      instance_of? Messaging::Queue::Substitute
    end
  end

  context "Equality" do
    context "Address is compared against itself" do
      test "Instances are equal" do
        assert substitute == substitute
      end
    end

    context "Address is compared against another substitute" do
      test "Instances are not equal" do
        refute substitute == Messaging::Address::Substitute.build
      end
    end
  end
end
