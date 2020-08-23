require_relative '../../test_init'

context "Supervisor Start Class Method" do
  supervisor_address = :not_assigned

  Fixtures::ExecuteWithinThread.() do
    test_thread = Thread.current
    supervisor_thread = nil

    Supervisor.start do |supervisor|
      Controls::Actor::StopsImmediately.start

      supervisor_address = supervisor.address
      supervisor_thread = Thread.current
    end

    test "Supervisor address is assigned" do
      address = Supervisor::Address::Get.()

      assert address == supervisor_address
    end

    test "Supervisor is run inside its own thread" do
      refute supervisor_thread == test_thread
    end
  end
end
