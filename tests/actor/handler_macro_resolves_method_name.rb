require_relative '../test_init'

context "Handler class macro resolves a method name from a message pattern" do
  context "Message pattern is specified as a class" do
    cls = Controls::Message::Example
    method_name = Actor::Module::HandleMacro::MethodName.get cls

    test "Class name is used to derive method name" do
      assert method_name == :handle_example
    end
  end

  context "Message pattern is an instance of a message (which can be any object)" do
    message = Controls::Message.example

    method_name = Actor::Module::HandleMacro::MethodName.get message

    test "Class name is used to derive method name" do
      assert method_name == :handle_example
    end
  end

  context "Message pattern is a pascal cased string" do
    method_name = Actor::Module::HandleMacro::MethodName.get 'PascalCasedString1111Example'

    test "String casing is converted to underscore case" do
      assert method_name == :handle_pascal_cased_string1111_example
    end
  end

  context "Message pattern is a symbol" do
    method_name = Actor::Module::HandleMacro::MethodName.get :SomeSymbol

    test "Handle prefix is attached to symbol without other modifications" do
      assert method_name == :handle_SomeSymbol
    end
  end
end
