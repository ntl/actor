require_relative '../../test_init'

context "Send, Sends Module Message" do
  message = Controls::Message::ModuleMessage

  address = Messaging::Address.build

  send = Messaging::Send.new
  send.(message, address)

  test "Message name, not module, is sent" do
    assert address.queue.deq == :module_message
  end
end
