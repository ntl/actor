require_relative '../../test_init'

context "Supervisor Start Class Method" do
  thread_group = ThreadGroup.new
  supervisor_address = :not_assigned

  Fixtures::ExecuteWithinThread.() do
    test_thread = Thread.current
    supervisor_thread = nil

    thread_group.add test_thread

    Supervisor.start do |supervisor|
      Controls::Actor::StopsImmediately.start

      supervisor_address = supervisor.address
      supervisor_thread = Thread.current
    end

    test "Supervisor address is assigned to thread group" do
      address = Supervisor::Address::Get.(thread_group)

      assert address == supervisor_address
    end

    test "Supervisor is run inside its own thread" do
      refute supervisor_thread == test_thread
    end
  end
end
