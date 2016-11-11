require_relative '../../test_init'

context "Message Class is Matched" do
  context "Message class is matched against another message" do
    test "Returns true if other message name matches" do
      other_message = Fixtures::Controls::Message.example

      assert Fixtures::Controls::Message::SomeMessage === other_message
    end

    test "Returns false if other message name does not match" do
      other_message = Fixtures::Controls::Message::OtherMessage.new

      refute Fixtures::Controls::Message::SomeMessage === other_message
    end
  end

  context "Message class is matched against a symbol" do
    test "Returns true if symbol matches message name" do
      assert Fixtures::Controls::Message::SomeMessage === :some_message
    end

    test "Returns false if symbol does not match message name" do
      refute Fixtures::Controls::Message::SomeMessage === :other_message
    end
  end

  context "Module that extends Message is matched" do
    context "Module is matched against another module" do
      test "Returns true if module itself is specified" do
        other_module = Fixtures::Controls::Message::ModuleMessage

        assert Fixtures::Controls::Message::ModuleMessage === other_module
      end

      test "Returns false if other module is specified" do
        other_module = Fixtures::Controls::Message::OtherMessage

        refute Fixtures::Controls::Message::ModuleMessage === other_module
      end
    end

    context "Module is matched against a symbol" do
      test "Returns true if symbol matches message name" do
        assert Fixtures::Controls::Message::ModuleMessage === :module_message
      end

      test "Returns false if symbol does not match message name" do
        refute Fixtures::Controls::Message::ModuleMessage === :other_message
      end
    end
  end
end
