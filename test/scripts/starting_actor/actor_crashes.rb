require_relative '../../test_init'

context "Actor Lifecycle, Actor Crashes" do
  supervisor_address = Messaging::Address.build

  thread_group = ThreadGroup.new

  actor, thread = Fixtures::ExecuteWithinThread.(thread_group) do
    Supervisor::Address::Put.(supervisor_address)

    Start.(Controls::Actor::CrashesImmediately)
  end

  thread.join

  read = Messaging::Read.build supervisor_address

  test "Actor started is sent to supervisor address" do
    actor_stopped = Messages::ActorStarted.new actor.address

    assert read do
      next_message? actor_stopped
    end
  end

  test "Actor crashed is sent to supervisor address" do
    error = Controls::Error.example

    actor_crashed = Messages::ActorCrashed.new error

    assert read do
      next_message? actor_crashed
    end
  end
end
