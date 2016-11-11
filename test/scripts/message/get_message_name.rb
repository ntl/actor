require_relative '../../test_init'

context "Message Module, Get Message Name" do
  context "Symbol is specified" do
    message_name = Messaging::Message::Name.get :SOME_SYMBOL

    test "Symbol is returned unaltered" do
      assert message_name == :SOME_SYMBOL
    end
  end

  context "Module is specified" do
    mod = Module.new do
      define_singleton_method :name do
        'SomeNamespace::SomeModule'
      end
    end

    message_name = Messaging::Message::Name.get mod

    test "Module name is stripped of namespaces and converted to underscore casing" do
      assert message_name == :some_module
    end
  end

  context "Class is specified" do
    cls = Class.new do
      define_singleton_method :name do
        'SomeNamespace::SomeClass'
      end
    end

    message_name = Messaging::Message::Name.get cls

    test "Class name is stripped of namespaces and converted to underscore casing" do
      assert message_name == :some_class
    end
  end

  context "String is specified" do
    message_name = Messaging::Message::Name.get 'SomeNamespace::SomeString'

    test "String is handled as a constant name" do
      assert message_name == :some_string
    end
  end

  context "Object is specified" do
    cls = Class.new do
      define_singleton_method :name do
        'SomeNamespace::SomeObject'
      end
    end

    object = cls.new

    message_name = Messaging::Message::Name.get object

    test "String is handled as a constant name" do
      assert message_name == :some_object
    end
  end
end
