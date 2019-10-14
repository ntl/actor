require_relative '../../test_init'

context "Reader, Dependency Module" do
  context "Class includes dependency module" do
    cls = Class.new do
      include Messaging::Read::Dependency
    end

    context "Object is instantiated" do
      object = cls.new

      test "Reader attribute getter returns substitute" do
        assert object.read.instance_of?(Messaging::Read::Substitute)
      end

      context "Reader attribute is specified" do
        address = Controls::Address.example
        read = Messaging::Read.build address

        object.read = read

        test "Reader attribute is set to specified reader" do
          assert object.read == read
        end
      end
    end
  end
end
