require_relative '../test_init'

context "Supervisor is notified when actor has crashed" do
  actor = Controls::Actor::Crashes.example
  address = Controls::Address::Actor.example
  supervisor_address = Controls::Address::Supervisor.example

  start = Start.new
  start.supervisor_address = supervisor_address

  thread = start.(actor, address)
  thread.join

  test "Actor crashed message is sent to supervisor" do
    control_message = Controls::Message::ActorCrashed.example actor.error

    assert start.writer do
      written? do |msg, addr|
        next unless msg.instance_of? Messages::ActorCrashed

        msg == control_message and addr == supervisor_address
      end
    end
  end
end
