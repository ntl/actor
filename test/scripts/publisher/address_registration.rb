require_relative '../scripts_init'

context "Publisher, Registering and Unregistering Addresses" do
  publisher = Messaging::Publisher.new

  address = Messaging::Address.build

  context "Address is registered with publisher" do
    publisher.register address

    test "Publisher has registered address" do
      assert publisher do
        registered? address
      end
    end
  end

  context "Address is unregistered from publisher" do
    publisher.unregister address

    test "Publisher has no longer registered address" do
      refute publisher do
        registered? address
      end
    end
  end
end
