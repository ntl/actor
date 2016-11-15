require_relative '../../test_init'

context "Writer, Dependency Module" do
  cls = Class.new do
    include Messaging::Write::Dependency
  end

  context "Object is instantiated" do
    object = cls.new

    test "Writer attribute getter returns substitute" do
      assert object.write do
        instance_of? Messaging::Write::Substitute
      end
    end

    context "Writer attribute is specified" do
      write = Messaging::Write.new

      object.write = write

      test "Writer attribute is set to specified writer" do
        assert object.write == write
      end
    end
  end
end
