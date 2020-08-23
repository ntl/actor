require_relative '../../test_init'

context "Supervisor Handles Final Actor Crashed Message" do
  actor_crashed = Controls::Message::ActorCrashed.example
  supervisor = Supervisor.new

  supervisor.actor_count = 1

  supervisor.handle actor_crashed

  test "Supervisor sends itself the stop message" do
    assert supervisor.send.sent?(Messages::Stop, queue: supervisor.queue)
  end
end
