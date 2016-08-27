require_relative '../../test_init'

context "Consuming an address whose queue is not empty" do
  address = Messaging::Address.get
  consumer = Messaging::Consumer.build address

  address.queue.write 'some-message'

  test "Message is returned" do
    assert consumer.next == 'some-message'
  end
end
