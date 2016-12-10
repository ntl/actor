require_relative '../../test_init'

context "Publisher, Publishes Message" do
  address = Controls::Address.example

  context "Multiple addresses are registered" do
    other_address = Controls::Address::Other.example

    publish = Messaging::Publish.new
    publish.register address
    publish.register other_address
    publish.(:some_message)

    test "Message is sent each registered address and is allowed to block" do
      assert publish.send do
        sent? :some_message, address: address
      end

      assert publish.send do
        sent? :some_message, address: other_address
      end
    end
  end

  context "Wait is not specified" do
    publish = Messaging::Publish.new
    publish.register address
    publish.(:some_message)

    test "Send operation is allowed to block" do
      assert publish.send do
        sent? wait: true
      end
    end
  end

  context "Wait is disabled" do
    publish = Messaging::Publish.new
    publish.register address
    publish.(:some_message, wait: false)

    test "Send operation is not allowed to block" do
      assert publish.send do
        sent? wait: false
      end
    end
  end
end
