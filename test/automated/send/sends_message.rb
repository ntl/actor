require_relative '../../test_init'

context "Send, Sends Message" do
  queue = Messaging::Queue.get

  send = Messaging::Send.new
  send.(:some_message, queue)

  test "Message is sent to queue of specified queue" do
    assert queue.size == 1
    assert queue.deq == :some_message
  end
end
