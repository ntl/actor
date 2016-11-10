require_relative '../../test_init'

context "Writer, Dependency Module" do
  cls = Class.new do
    include Messaging::Writer::Dependency
  end

  context "Object is instantiated" do
    object = cls.new

    test "Writer attribute getter returns substitute" do
      assert object.writer do
        instance_of? Messaging::Writer::Substitute
      end
    end

    context "Writer attribute is specified" do
      writer = Messaging::Writer.new

      object.writer = writer

      test "Writer attribute is set to specified writer" do
        assert object.writer == writer
      end
    end
  end
end
