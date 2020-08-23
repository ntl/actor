require_relative '../../test_init'

context "Send, Sends Module Message" do
  message = Controls::Message::ModuleMessage

  queue = Messaging::Queue.get

  send = Messaging::Send.new
  send.(message, queue)

  test "Message name, not module, is sent" do
    assert queue.deq == :module_message
  end
end
