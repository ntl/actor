require_relative '../../test_init'

context "Actor Lifecycle, Actor Crashes" do
  supervisor_queue = Messaging::Queue.get

  Supervisor::Queue::Put.(supervisor_queue)

  queue, thread = Controls::Actor::CrashesImmediately.start(include: :thread)

  thread.join

  read = Messaging::Read.build supervisor_queue

  test "Actor started is sent to supervisor queue" do
    assert read.next_message?(Messages::ActorStarted)
  end

  test "Actor crashed is sent to supervisor queue" do
    assert read.next_message?(Messages::ActorCrashed)
  end
end
