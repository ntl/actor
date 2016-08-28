require_relative '../test_init'

context "Thread is spawned with actor in paused state" do
  actor_cls = Class.new do
    include Actor
  end

  address, thread, actor = actor_cls.spawn include: %i(thread actor)

  initial_state = actor.actor_state

  Messaging::Writer.write Message::Stop.new, address

  thread.join

  test "Initial state is paused" do
    assert initial_state == :paused
  end
end
