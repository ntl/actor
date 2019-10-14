require_relative '../../test_init'

context "Address, Substitute" do
  substitute = Messaging::Address::Substitute.build

  test "ID is none" do
    assert substitute.id == '(none)'
  end

  test "Queue attribute is substitute" do
    assert substitute.queue.instance_of?(Messaging::Queue::Substitute)
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

  context "Queue depth" do
    test "Value is zero" do
      assert substitute.queue_depth == 0
    end

    context "Value is set" do
      substitute.queue_depth = 11

      test "Specified value is returned" do
        assert substitute.queue_depth == 11
      end
    end
  end

  context "Queue limit" do
    test "Value is infinite" do
      assert substitute.queue_limit == Float::INFINITY
    end
  end
end
