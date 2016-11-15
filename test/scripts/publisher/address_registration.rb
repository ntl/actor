require_relative '../../test_init'

context "Publisher, Registering and Unregistering Addresses" do
  publish = Messaging::Publish.new

  address = Controls::Address.example

  context "Address is registered with publisher" do
    publish.register address

    test "Publisher has registered address" do
      assert publish do
        registered? address
      end
    end
  end

  context "Address is unregistered from publisher" do
    publish.unregister address

    test "Publisher has no longer registered address" do
      refute publish do
        registered? address
      end
    end
  end
end
