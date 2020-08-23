require_relative '../../test_init'

context "Get Address of Supervisor" do
  context "No supervisor address is registered" do
    Supervisor::Address::Put.(nil)

    address = Supervisor::Address::Get.()

    test "Null address is returned" do
      assert address.instance_of?(Messaging::Address::None)
    end
  end

  context "Supervisor address is registered" do
    registered_address = Controls::Address.example

    Supervisor::Address::Put.(registered_address)

    context "Get Address" do
      address = Supervisor::Address::Get.()

      test "Supervisor address is returned" do
        assert address == registered_address
      end
    end
  end

  context "Supervisor address is unregistered" do
    Supervisor::Address::Put.(nil)

    context "Get Address" do
      address = Supervisor::Address::Get.()

      test "Null address is returned" do
        assert address.instance_of?(Messaging::Address::None)
      end
    end
  end
end
