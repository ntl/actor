require_relative '../../test_init'

context "Supervisor Start Class Method" do
  thread_group = ThreadGroup.new
  supervisor_address = :not_assigned

  Fixtures::ExecuteWithinThread.() do
    thread_group.add Thread.current

    Supervisor.start do |supervisor|
      Controls::Actor::StopsImmediately.start

      supervisor_address = supervisor.address
    end
  end

  test "Supervisor address is assigned to thread group" do
    address = Supervisor::Address::Get.(thread_group)

    assert address == supervisor_address
  end
end
