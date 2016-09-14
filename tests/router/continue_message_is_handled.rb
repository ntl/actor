require_relative '../test_init'

context "Continue message is handled by router" do
  context "No input streams contain new messages" do
    router = Router.new
    return_value = router.handle :continue

    test "Continue message is returned" do
      assert return_value == :continue
    end

    test "Thread is put to sleep for one millisecond" do
      assert router.kernel do
        slept? Duration.millisecond
      end
    end
  end

  context "Input stream for a route contains new messages" do
    message = Controls::Message.example

    input_reader = Messaging::Read::Substitute.new
    input_reader.add_message message

    output_address = Controls::Address.example

    router = Router.new
    router.add input_reader, output_address

    return_value = router.handle :continue

    test "Message is written to output address" do
      assert router.writer do
        written? do |msg, addr|
          msg == message and addr == output_address
        end
      end
    end

    test "Continue message is returned" do
      assert return_value == :continue
    end

    test "Thread is not put to sleep" do
      refute router.kernel, &:slept?
    end
  end
end
