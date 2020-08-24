require_relative '../../test_init'

context "Actor Lifecycle" do
  supervisor_queue = Messaging::Queue.get

  Supervisor::Queue::Put.(supervisor_queue)

  _, thread = Controls::Actor::StopsImmediately.start(include: :thread)

  thread.join

  read = Messaging::Read.build(supervisor_queue)

  test "Actor started is sent to supervisor queue" do
    assert read.next_message?(Messages::ActorStarted)
  end

  test "Actor stopped is sent to supervisor queue" do
    assert read.next_message?(Messages::ActorStopped)
  end
end
