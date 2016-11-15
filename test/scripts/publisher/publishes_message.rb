require_relative '../../test_init'

context "Publisher, Publishes Message" do
  address = Controls::Address.example

  context "Multiple addresses are registered" do
    other_address = Controls::Address::Other.example

    publish = Messaging::Publish.new
    publish.register address
    publish.register other_address
    publish.(:some_message)

    test "Message is written each registered address and is allowed to block" do
      assert publish.write do
        written? :some_message, address: address
      end

      assert publish.write do
        written? :some_message, address: other_address
      end
    end
  end

  context "Wait is not specified" do
    publish = Messaging::Publish.new
    publish.register address
    publish.(:some_message)

    test "Write operation is allowed to block" do
      assert publish.write do
        written? wait: true
      end
    end
  end

  context "Wait is disabled" do
    publish = Messaging::Publish.new
    publish.register address
    publish.(:some_message, wait: false)

    test "Write operation is not allowed to block" do
      assert publish.write do
        written? wait: false
      end
    end
  end
end
