require_relative '../test_init'

context "Action is specified by actor implementation" do
  actor_cls = Class.new do
    include Actor

    def action
      @acted = true
      raise StopIteration
    end

    def action_executed?
      @acted
    end
  end

  _, actor, thread = actor_cls.start include: %i(actor thread)

  thread.join

  test "Action is executed" do
    assert actor.action_executed?
  end
end
