require_relative '../../test_init'

context "Actor Module, Handle Method Arity" do
  cls = Fixtures::Controls::Actor.define do
    handle :arity_0 do
      :arity_0
    end

    handle :arity_1 do |msg|
      msg
    end

    handle :arity_minus_1 do |msg=nil|
      msg
    end

    handle :arity_2 do |a,b|
    end

    handle :arity_rest do |*rest|
      rest
    end
  end

  actor = cls.new

  context "Handler method accepts no arguments" do
    return_value = actor.handle :arity_0

    test "Method is invoked" do
      assert return_value == :arity_0
    end
  end

  context "Handler method accepts a required argument" do
    return_value = actor.handle :arity_1

    test "Method is invoked and passed the message" do
      assert return_value == :arity_1
    end
  end

  context "Handler method accepts an optional argument" do
    return_value = actor.handle :arity_minus_1

    test "Method is invoked and passed the message" do
      assert return_value == :arity_minus_1
    end
  end

  context "Handler method accepts a variable number of arguments" do
    return_value = actor.handle :arity_rest

    test "Method is invoked and passed the massge" do
      assert return_value == [:arity_rest]
    end
  end

  context "Handler method accepts more than one argument" do
    test "ArgumentError is raised" do
      assert proc { actor.handle :arity_2 } do
        raises_error? ArgumentError
      end
    end
  end
end
