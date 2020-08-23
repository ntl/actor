require_relative '../../test_init'

context "Supervisor Handles Final Actor Stopped Message" do
  actor_stopped, actor = Controls::Message::ActorStopped.pair
  supervisor = Supervisor.new

  supervisor.actor_count = 1

  supervisor.handle actor_stopped

  test "Supervisor sends itself the stop message" do
    assert supervisor.send.sent?(Messages::Stop, queue: supervisor.queue)
  end
end
