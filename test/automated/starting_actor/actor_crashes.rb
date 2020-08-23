require_relative '../../test_init'

context "Actor Lifecycle, Actor Crashes" do
  supervisor_address = Messaging::Address.build

  actor, thread = Fixtures::ExecuteWithinThread.() do
    Supervisor::Address::Put.(supervisor_address)

    Start.(Controls::Actor::CrashesImmediately)
  end

  thread.join

  read = Messaging::Read.build supervisor_address

  test "Actor started is sent to supervisor address" do
    actor_stopped = Messages::ActorStarted.new actor.address, actor

    assert read.next_message?(actor_stopped)
  end

  test "Actor crashed is sent to supervisor address" do
    error = Controls::Error.example

    actor_crashed = Messages::ActorCrashed.new error, actor

    assert read.next_message?(actor_crashed)
  end
end
