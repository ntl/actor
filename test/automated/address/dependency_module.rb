require_relative '../../test_init'

context "Address, Dependency Module" do
  context "Class includes dependency module" do
    cls = Class.new do
      include Messaging::Address::Dependency
    end

    context "Object is instantiated" do
      object = cls.new

      test "Reader attribute getter returns substitute address" do
        assert object.address.instance_of?(Messaging::Address::None)
      end

      context "Address attribute is specified" do
        address = Controls::Address.example

        object.address = address

        test "Address attribute is set to specified reader" do
          assert object.address == address
        end
      end
    end
  end
end
