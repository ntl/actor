require_relative '../scripts_init'

context "Publisher, Dependency Module" do
  cls = Class.new do
    include Messaging::Publisher::Dependency
  end

  context "Object is instantiated" do
    object = cls.new

    test "Publisher attribute getter returns substitute" do
      assert object.publisher do
        instance_of? Messaging::Publisher::Substitute
      end
    end

    context "Publisher attribute is specified" do
      publisher = Messaging::Publisher.build

      object.publisher = publisher

      test "Publisher attribute is set to specified publisher" do
        assert object.publisher == publisher
      end
    end
  end
end
