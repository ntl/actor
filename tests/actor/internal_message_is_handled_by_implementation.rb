require_relative '../test_init'

context "Handler specified by actor implementation handles internal message" do
  address, thread, actor = Controls::Actor::Example.start include: %i(thread actor)

  stop_message = Message::Stop.new

  Messaging::Writer.write stop_message, address

  thread.join

  test "Internal message is handled" do
    assert actor do
      handled_message? stop_message
    end
  end
end
