require_relative '../test_init'

context "Shutdown message is handled by supervisor" do
  supervisor = Supervisor.new
  supervisor.broadcast_address = Controls::Address::Supervisor::Broadcast.example
  supervisor.router_address = Controls::Address::Router.example

  return_value = supervisor.handle :shutdown

  test "Stop message is written to broadcast address" do
    assert supervisor.writer do
      written? do |msg, addr|
        msg.instance_of? Messages::Stop and addr == supervisor.broadcast_address
      end
    end
  end

  test "Stop message is written to router address" do
    assert supervisor.writer do
      written? do |msg, addr|
        msg.instance_of? Messages::Stop and addr == supervisor.router_address
      end
    end
  end

  test "Continue message is returned" do
    assert return_value == :continue
  end
end
