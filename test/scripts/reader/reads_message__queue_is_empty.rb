require_relative '../scripts_init'

context "Reader, Reads Message from an Empty Queue" do
  queue = Queue.new

  reader = Messaging::Reader.new queue

  context "Wait is not specified" do
    write_thread = Thread.new do
      Thread.pass until queue.num_waiting > 0
      queue.enq :some_message
    end

    test "Thread is blocked until another thread writes to queue" do
      message = reader.read

      assert message == :some_message
    end
  end

  context "Wait is disabled" do
    test "Nothing is returned" do
      message = reader.read wait: false

      assert message.nil?
    end
  end
end
