require_relative '../test_init'

context "Handler specified by actor implementation handles internal message" do
  actor_cls = Class.new do
    include Actor

    def handle message
      @handled = true if Message::Stop === message
    end

    def handled_internal_message?
      @handled
    end
  end

  address, thread, actor = actor_cls.start include: %i(thread actor)

  Messaging::Writer.write(
    Message::Stop.new,
    address
  )

  thread.join

  test "Internal message is handled" do
    assert actor.handled_internal_message?
  end
end
