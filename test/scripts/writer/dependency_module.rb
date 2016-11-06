require_relative '../scripts_init'

context "Writer, Dependency Module" do
  cls = Class.new do
    include Writer::Dependency
  end

  context "Object is instantiated" do
    object = cls.new

    test "Writer attribute getter returns substitute" do
      assert object.writer do
        instance_of? Writer::Substitute
      end
    end

    context "Writer attribute is specified" do
      writer = Writer.new

      object.writer = writer

      test "Writer attribute is set to specified writer" do
        assert object.writer == writer
      end
    end
  end
end
