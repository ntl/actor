require_relative '../scripts_init'

context "Publisher, Publishes Message" do
  address = Messaging::Address.build

  context "Multiple addresses are registered" do
    other_address = Messaging::Address.build

    publisher = Messaging::Publisher.new
    publisher.register address
    publisher.register other_address
    publisher.publish :some_message

    test "Message is written each registered address and is allowed to block" do
      assert publisher.writer do
        written? :some_message, address: address
      end

      assert publisher.writer do
        written? :some_message, address: other_address
      end
    end
  end

  context "Wait is not specified" do
    publisher = Messaging::Publisher.new
    publisher.register address
    publisher.publish :some_message

    test "Write operation is allowed to block" do
      assert publisher.writer do
        written? wait: true
      end
    end
  end

  context "Wait is disabled" do
    publisher = Messaging::Publisher.new
    publisher.register address
    publisher.publish :some_message, wait: false

    test "Write operation is not allowed to block" do
      assert publisher.writer do
        written? wait: false
      end
    end
  end
end
