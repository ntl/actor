require_relative '../test_init'

context "Actor handles a message" do
  message = Controls::Message.example

  context "No handler is defined" do
    actor = Controls::Actor::Singleton.define

    test "No action is taken" do
      refute proc { actor.handle message } do
        raises_error?
      end
    end
  end

  context "Handler that accepts no arguments is defined" do
    actor = Controls::Actor::Singleton.define do
      handle message do :handled end
    end

    test "Method is executed without any arguments" do
      assert actor.handle(message) == :handled
    end
  end

  context "Handler that accepts one required argument is defined" do
    actor = Controls::Actor::Singleton.define do
      handle message do |msg| msg end
    end

    test "Method is passed the message" do
      assert actor.handle(message) == message
    end
  end

  context "Handler that accepts a single optional argument is defined" do
    actor = Controls::Actor::Singleton.define do
      handle message do |msg=nil| return msg end
    end

    test "Method is passed the message" do
      assert actor.handle(message) == message
    end
  end

  context "Handler that accepts more than one required argument is defined" do
    actor = Controls::Actor::Singleton.define do
      handle message do |msg, other_arg| end
    end

    test "Argument error is raised" do
      assert proc { actor.handle message } do
        raises_error? ArgumentError
      end
    end
  end
end
