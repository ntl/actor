require_relative '../../test_init'

context "Reading an address whose queue is not empty" do
  address = Messaging::Address.get
  reader = Messaging::Reader.build address

  address.queue.write 'some-message'

  test "Message is returned" do
    assert reader.next == 'some-message'
  end
end
