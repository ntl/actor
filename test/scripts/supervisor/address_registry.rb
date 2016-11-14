require_relative '../../test_init'

context "Get Address of Supervisor" do
  context "No supervisor address is registered" do
    address = Supervisor::Address::Get.()

    test "Null address is returned" do
      assert address do
        instance_of? Messaging::Address::None
      end
    end
  end

  context "Supervisor address is registered for a thread group" do
    registered_address = Fixtures::Controls::Address.example

    thread_group = ThreadGroup.new

    Fixtures::ExecuteWithinThread.(thread_group) do
      Supervisor::Address::Put.(registered_address)
    end

    context "Address is queried from thread that belongs to another group" do
      address = Fixtures::ExecuteWithinThread.() do
        Supervisor::Address::Get.()
      end

      test "Null address is returned" do
        assert address do
          instance_of? Messaging::Address::None
        end
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
