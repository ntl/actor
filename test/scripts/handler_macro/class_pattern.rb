require_relative '../scripts_init'

context "Actor Module, Handle Macro (Messages are Matched by Class)" do
  cls = Class.new do
    include Actor

    attr_accessor :handler_actuated

    handle Fixtures::Controls::Message::SomeMessage do
      self.handler_actuated = true
    end
  end

  context "Actor handles an instance of specified class" do
    message = Fixtures::Controls::Message::SomeMessage.new

    actor = cls.new
    actor.handle message

    test "Handler is actuated" do
      assert actor.handler_actuated
    end
  end

  context "Actor handles an instance of another class" do
    other_class = Class.new
    message = other_class.new

    actor = cls.new
    actor.handle message

    test "Handler is not actuated" do
      refute actor.handler_actuated
    end
  end

  context "Actor handles an instance of a subclass of specified class" do
    subclass = Class.new Fixtures::Controls::Message::SomeMessage
    message = subclass.new

    actor = cls.new
    actor.handle message

    test "Handler is not actuated" do
      refute actor.handler_actuated
    end
  end

  context "Actor handles a symbol corresonding to specified class" do
    actor = cls.new
    actor.handle :some_message

    test "Handler is actuated" do
      assert actor.handler_actuated
    end
  end

  context "Actor handles a symbol not corresonding to specified class" do
    actor = cls.new
    actor.handle :other_message

    test "Handler is not actuated" do
      refute actor.handler_actuated
    end
  end
end
