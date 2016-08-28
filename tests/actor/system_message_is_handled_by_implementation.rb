require_relative '../test_init'

context "Handler specified by actor implementation handles system message" do
  actor_cls = Class.new do
    include Actor

    def handle message
      @handled = true if Messaging::SystemMessage::Stop === message
    end

    def handled_system_message?
      @handled
    end
  end

  address, thread, actor = actor_cls.start include: %i(thread actor)

  Messaging::Writer.write(
    Messaging::SystemMessage::Stop.new,
    address
  )

  thread.join

  test "System message is handled" do
    assert actor.handled_system_message?
  end
end
