require_relative '../test_init'

context "Supervisor is started" do
  supervisor_address, thread, supervisor = Supervisor.start include: %i(thread actor)

  test "Broadcast address is assigned" do
    assert supervisor.broadcast_address.instance_of? Address
  end

  test "Router address is assigned" do
    assert supervisor.router_address.instance_of? Address
  end

  test "Thread group is configured" do
    assert supervisor.thread_group do
      instance_of? ThreadGroup
    end
  end

  context "Supervisor is stopped" do
    Messaging::Write.(Messages::Stop.new, supervisor_address)

    test "Thread eventually exits gracefully" do
      return_value = thread.join Duration.millisecond

      assert return_value == thread
      assert thread.status == false
    end
  end
end
