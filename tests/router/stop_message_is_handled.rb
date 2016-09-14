require_relative '../test_init'

context "Stop message is handled by router" do
  output_address = Controls::Address.example
  reader = Messaging::Read::Substitute.new

  context "No routes have any messages yet to be read" do
    router = Router.new

    router.add reader, output_address

    test "Stop iteration exception is raised" do
      assert proc { router.handle :stop } do
        raises_error? StopIteration
      end
    end
  end

  context "Some routes have messages yet to be read" do
    message = Controls::Message.example

    router = Router.new
    router.add reader, output_address
    reader.add_message message

    return_value = router.handle :stop

    test "Messages are routed" do
      assert router.writer do
        written? do |msg, addr|
          msg == message and addr == output_address
        end
      end
    end

    test "Stop message is returned" do
      assert return_value == :stop
    end
  end
end
