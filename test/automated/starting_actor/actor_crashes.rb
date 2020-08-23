require_relative '../../test_init'

context "Actor Lifecycle, Actor Crashes" do
  supervisor_queue = Messaging::Queue.get

  actor, thread = Fixtures::ExecuteWithinThread.() do
    Supervisor::Queue::Put.(supervisor_queue)

    Start.(Controls::Actor::CrashesImmediately)
  end

  thread.join

  read = Messaging::Read.build supervisor_queue

  test "Actor started is sent to supervisor queue" do
    actor_stopped = Messages::ActorStarted.new actor.queue, actor

    assert read.next_message?(actor_stopped)
  end

  test "Actor crashed is sent to supervisor queue" do
    error = Controls::Error.example

    actor_crashed = Messages::ActorCrashed.new error, actor

    assert read.next_message?(actor_crashed)
  end
end
