require_relative '../scripts_init'

context "Reader, Dependency Module" do
  context "Class includes dependency module" do
    cls = Class.new do
      include Reader::Dependency
    end

    context "Object is instantiated" do
      object = cls.new

      test "Reader attribute getter returns substitute" do
        assert object.reader do
          instance_of? Reader::Substitute
        end
      end

      context "Reader attribute is specified" do
        address = Address.build
        reader = Reader.build address

        object.reader = reader

        test "Reader attribute is set to specified reader" do
          assert object.reader == reader
        end
      end
    end
  end
end
