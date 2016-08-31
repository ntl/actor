require_relative '../test_init'

context "Handler is specified by actor implementation" do
  address, thread, actor = Controls::Actor::StopsImmediately.spawn include: %i(thread actor)

  message = Controls::Message.example

  Messaging::Writer.write message, address
  Messaging::Writer.write Message::Resume.new, address

  thread.join

  test "Message is handled" do
    assert actor do
      handled_message? message
    end
  end
end
