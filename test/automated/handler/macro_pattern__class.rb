require_relative '../../test_init'

context "Actor Module, Handle Macro Pattern (Message is Matched by Class)" do
  cls = Controls::Actor.define do 
    attr_accessor :handler_actuated

    handle Controls::Message::SomeMessage do
      self.handler_actuated = true
    end
  end

  context "Actor handles an instance of specified class" do
    message = Controls::Message::SomeMessage.new

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
    subclass = Class.new Controls::Message::SomeMessage
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
