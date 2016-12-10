require_relative '../../test_init'

context "Send, Dependency Module" do
  cls = Class.new do
    include Messaging::Send::Dependency
  end

  context "Object is instantiated" do
    object = cls.new

    test "Send attribute getter returns substitute" do
      assert object.send do
        instance_of? Messaging::Send::Substitute
      end
    end

    context "Send attribute is specified" do
      send = Messaging::Send.new

      object.send = send

      test "Send attribute is set to specified object" do
        assert object.send == send
      end
    end
  end
end
