require_relative '../../test_init'

context "Publisher, Dependency Module" do
  cls = Class.new do
    include Messaging::Publish::Dependency
  end

  context "Object is instantiated" do
    object = cls.new

    test "Publisher attribute getter returns substitute" do
      assert object.publish.instance_of?(Messaging::Publish::Substitute)
    end

    context "Publisher attribute is specified" do
      publish = Messaging::Publish.build

      object.publish = publish

      test "Publisher attribute is set to specified publisher" do
        assert object.publish == publish
      end
    end
  end
end
