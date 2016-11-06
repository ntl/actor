require_relative '../scripts_init'

context "Publisher, Publishes Message" do
  address1 = Address.build
  address2 = Address.build

  publisher = Publisher.build address1, address2

  publisher.publish :some_message

  test "Message is written to queue of each address" do
    assert address1.queue do
      size == 1 and deq == :some_message
    end

    assert address2.queue do
      size == 1 and deq == :some_message
    end
  end
end
