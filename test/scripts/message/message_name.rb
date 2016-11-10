require_relative '../../test_init'

context "Message, Message Name" do
  context do
    message_class = Fixtures::Controls::Message::SomeMessage

    context "Class method is queried" do
      message_name = message_class.message_name

      test "Constant name as underscore casing without namespace is returned" do
        assert message_name == :some_message
      end
    end

    context "Instance method is queried" do
      message = message_class.new

      message_name = message_class.message_name

      test "Constant name as underscore casing without namespace is returned" do
        assert message_name == :some_message
      end
    end
  end

  context "Specified message is a module that includes Message" do
    module_message = Fixtures::Controls::Message::ModuleMessage

    message_name = module_message.message_name

    test "Constant name as underscore casing without namespace is returned" do
      assert message_name == :module_message
    end
  end
end
