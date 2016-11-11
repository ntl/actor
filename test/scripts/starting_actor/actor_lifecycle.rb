require_relative '../../test_init'

context "Actor Lifecycle" do
  supervisor_address = Messaging::Address.build

  thread_group = ThreadGroup.new

  actor, thread = Fixtures::ExecuteWithinThread.(thread_group) do
    Supervisor::Address::Put.(supervisor_address)

    Start.(Fixtures::Controls::Actor::StopsImmediately)
  end

  thread.join

  reader = Messaging::Reader.build supervisor_address

  test "Actor started is written to supervisor address" do
    actor_stopped = Messages::ActorStarted.new actor.address

    assert reader do
      next_message? actor_stopped
    end
  end

  test "Actor stopped is written to supervisor address" do
    actor_stopped = Messages::ActorStopped.new actor.address

    assert reader do
      next_message? actor_stopped
    end
  end
end
