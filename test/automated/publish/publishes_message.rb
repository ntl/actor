require_relative '../../test_init'

context "Publisher, Publishes Message" do
  queue = Controls::Queue.example

  context "Multiple queuees are registered" do
    other_queue = Controls::Queue::Other.example

    publish = Messaging::Publish.new
    publish.register queue
    publish.register other_queue
    publish.(:some_message)

    test "Message is sent to each registered queue" do
      assert publish.send.sent?(:some_message, queue: queue)

      assert publish.send.sent?(:some_message, queue: other_queue)
    end
  end

  [["Wait is not specified", nil], ["Wait is disabled", false]].each do |prose, wait|
    context prose do
      publish = Messaging::Publish.new
      publish.register queue
      publish.(:some_message, wait: wait)

      test "Send operation is not permitted to block" do
        assert publish.send.sent?(wait: false)
      end
    end
  end

  context "Wait is enabled" do
    publish = Messaging::Publish.new
    publish.register queue
    publish.(:some_message, wait: true)

    test "Send operation is permitted to block" do
      assert publish.send.sent?(wait: true)
    end
  end
end
