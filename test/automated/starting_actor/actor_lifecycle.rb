require_relative '../../test_init'

context "Actor Lifecycle" do
  supervisor_address = Messaging::Address.build

  thread_group = ThreadGroup.new

  actor, thread = Fixtures::ExecuteWithinThread.(thread_group) do
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
