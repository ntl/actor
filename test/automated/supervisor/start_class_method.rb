require_relative '../../test_init'

context "Supervisor Start Class Method" do
  supervisor_queue = :not_assigned

  Fixtures::ExecuteWithinThread.() do
    test_thread = Thread.current
    supervisor_thread = nil

    Supervisor.start do |supervisor|
      Controls::Actor::StopsImmediately.start

      supervisor_queue = supervisor.queue
      supervisor_thread = Thread.current
    end

    test "Supervisor queue is assigned" do
      queue = Supervisor::Queue::Get.()

      assert queue == supervisor_queue
    end

    test "Supervisor is run inside its own thread" do
      refute supervisor_thread == test_thread
    end
  end
end
