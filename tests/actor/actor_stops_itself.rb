require_relative '../test_init'

context "Actor stops itself" do
  actor_cls = Class.new do
    include Actor

    def action
      raise StopIteration
    end
  end

  _, actor, thread = actor_cls.start include: %i(actor thread)

  thread.join

  test "State is stopped" do
    assert actor.actor_state == :stopped
  end
end
