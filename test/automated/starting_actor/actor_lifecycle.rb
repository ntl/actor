require_relative '../../test_init'

context "Actor Lifecycle" do
  supervisor_address = Messaging::Address.build

  actor, thread = Fixtures::ExecuteWithinThread.() do
    Supervisor::Address::Put.(supervisor_address)

    Start.(Controls::Actor::StopsImmediately)
  end

  thread.join

  read = Messaging::Read.build supervisor_address

  test "Actor started is sent to supervisor address" do
    actor_stopped = Messages::ActorStarted.new actor.address, actor

    assert read.next_message?(actor_stopped)
  end

  test "Actor stopped is sent to supervisor address" do
    actor_stopped = Messages::ActorStopped.new actor.address, actor

    assert read.next_message?(actor_stopped)
  end
end
