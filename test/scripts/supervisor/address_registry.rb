require_relative '../../test_init'

context "Get Address of Supervisor" do
  context "No supervisor address is registered" do
    address = Supervisor::Address::Get.()

    test "Nothing is returned" do
      assert address == nil
    end
  end

  context "Supervisor address is registered for a thread group" do
    registered_address = Messaging::Address.build

    thread_group = ThreadGroup.new

    Fixtures::ExecuteWithinThread.(thread_group) do
      Supervisor::Address::Put.(registered_address)
    end

    context "Address is queried from thread that belongs to another group" do
      address = Fixtures::ExecuteWithinThread.() do
        Supervisor::Address::Get.()
      end

      test "Nothing is returned" do
        assert address == nil
      end
    end

    context "Address is queried from thread belonging to specified group" do
      address = nil

      Fixtures::ExecuteWithinThread.(thread_group) do
        address = Supervisor::Address::Get.()
      end

      test "Supervisor address is returned" do
        assert address == registered_address
      end
    end
  end
end
