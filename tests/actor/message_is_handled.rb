require_relative '../test_init'

context "Actor handles a message" do
  message = Controls::Message.example
  address = Controls::Address.example

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
      assert actor.handle(message, address) == message
    end
  end

  context "Handler that accepts two required arguments is defined" do
    actor = Controls::Actor::Singleton.define do
      handle message do |msg, addr| return msg, addr end
    end

    test "Method is passed both the message and the address" do
      assert actor.handle(message, address) == [message, address]
    end
  end

  context "Handler that accepts a single optional argument is defined" do
    actor = Controls::Actor::Singleton.define do
      handle message do |msg=nil| return msg end
    end

    test "Method is passed the message" do
      assert actor.handle(message, address) == message
    end
  end

  context "Handler that accepts two optional arguments is defined" do
    actor = Controls::Actor::Singleton.define do
      handle message do |msg=nil, attr=nil| return msg, attr end
    end

    test "Method is passed both the message and the address" do
      assert actor.handle(message, address) == [message, address]
    end
  end

  context "Handler that accepts one required and one optional argument is defined" do
    actor = Controls::Actor::Singleton.define do
      handle message do |msg, attr=nil| return msg, attr end
    end

    test "Method is passed both the message and the address" do
      assert actor.handle(message, address) == [message, address]
    end
  end

  context "Handler that accepts more than two required argument is defined" do
    actor = Controls::Actor::Singleton.define do
      handle message do |msg, attr, other_arg| end
    end

    test "Argument error is raised" do
      assert proc { actor.handle message, address } do
        raises_error? ArgumentError
      end
    end
  end
end
