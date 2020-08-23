require_relative '../../test_init'

context "Actor Handles a Message, Handler Returns New Message" do
  queue = Controls::Queue.example
  message = Controls::Message.example

  actor = Controls::Actor.define_singleton do
    handle message do |msg|
      msg
    end
  end

  actor.queue = queue

  actor.handle message

  test "Message is sent to queue of actor" do
    assert actor.send.sent?(message, queue: queue)
  end
end
