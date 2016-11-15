require_relative '../../test_init'

context "Reader, Reads Message" do
  queue = Queue.new
  queue.enq :some_message

  read = Messaging::Read.new queue

  message = read.()

  test "Message is read from queue" do
    assert message == :some_message
  end
end
