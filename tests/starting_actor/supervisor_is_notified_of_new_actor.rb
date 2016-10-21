require_relative '../test_init'

context "Supervisor is notified when actor is started" do
  actor = Controls::Actor::Stops.example
  address = Controls::Address::Actor.example
  supervisor_address = Controls::Address::Supervisor.example

  start = Start.new
  start.supervisor_address = supervisor_address

  thread = start.(actor, address)
  thread.join

  test "Actor started message is sent to supervisor" do
    control_message = Controls::Message::ActorStarted.example

    assert start.writer do
      written? do |msg, addr|
        next unless msg.is_a? Messages::ActorStarted
        msg.actor_address == address and addr == supervisor_address
      end
    end
  end
end
