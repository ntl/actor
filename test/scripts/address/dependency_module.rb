require_relative '../scripts_init'

context "Address, Dependency Module" do
  context "Class includes dependency module" do
    cls = Class.new do
      include Messaging::Address::Dependency
    end

    context "Object is instantiated" do
      object = cls.new

      test "Reader attribute getter returns null address" do
        assert object.address do
          instance_of? Messaging::Address::None
        end
      end

      context "Address attribute is specified" do
        address = Messaging::Address.build

        object.address = address

        test "Address attribute is set to specified reader" do
          assert object.address == address
        end
      end
    end
  end
end
