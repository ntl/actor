require_relative '../scripts_init'

context "Writer, Registering and Unregistering Addresses" do
  writer = Writer.new

  address = Address.build

  context "Address is registered with writer" do
    writer.register address

    test "Writer has registered address" do
      assert writer do
        registered? address
      end
    end
  end

  context "Address is unregistered from writer" do
    writer.unregister address

    test "Writer has no longer registered address" do
      refute writer do
        registered? address
      end
    end
  end
end
