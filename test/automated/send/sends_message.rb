require_relative '../../test_init'

context "Send, Sends Message" do
  address = Messaging::Address.build

  send = Messaging::Send.new
  send.(:some_message, address)

  test "Message is sent to queue of specified address" do
    assert address.queue.size == 1
    assert address.queue.deq == :some_message
  end
end
