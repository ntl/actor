require_relative '../../test_init'

context "Send, Sends Message" do
  address = Messaging::Address.build

  send = Messaging::Send.new
  send.(:some_message, address)

  test "Message is sent to queue of specified address" do
    assert address.queue do
      size == 1 and deq == :some_message
    end
  end
end
