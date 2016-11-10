require_relative '../../test_init'

context "Message, Message Name" do
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
