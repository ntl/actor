require_relative '../test_init'

context "Null stream" do
  null_stream = Stream::Null

  context "Queue is added" do
    test do
      queue = Queue.new

      refute proc { null_stream.add_queue queue } do
        raises_error?
      end
    end
  end

  context "Queue is removed" do
    test do
      queue = Queue.new

      refute proc { null_stream.remove_queue queue } do
        raises_error?
      end
    end
  end

  context "Message is written" do
    test do
      message = Object.new

      refute proc { null_stream.write message } do
        raises_error?
      end
    end
  end
end
