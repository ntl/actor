require_relative '../test_init'

context "Thread is spawned with actor in paused state" do
  address, thread, actor = Controls::Actor::Example.spawn include: %i(thread actor)

  initial_state = actor.actor_state

  Messaging::Writer.(Message::Stop.new, address)

  thread.join

  test "Initial state is paused" do
    assert initial_state == :paused
  end
end
