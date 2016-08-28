require_relative '../test_init'

context "Handler is specified by actor implementation" do
  actor_cls = Class.new do
    include Actor

    def action
      raise StopIteration
    end

    def handle message
      @handled = true if message == 'some-message'
    end

    def handled_message?
      @handled
    end
  end

  address, thread, actor = actor_cls.spawn include: %i(thread actor)

  Messaging::Writer.write 'some-message', address
  Messaging::Writer.write SystemMessage::Resume.new, address

  thread.join

  test "Message is handled" do
    assert actor.handled_message?
  end
end
