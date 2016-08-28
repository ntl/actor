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

  address, thread, actor = actor_cls.start include: %i(thread actor)

  Messaging::Writer.write(
    Messaging::SystemMessage::Resume.new,
    address
  )

  thread.join

  test "Action is executed" do
    assert actor.action_executed?
  end
end
