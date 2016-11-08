require_relative '../scripts_init'

context "Run Loop Handles a Message, Handler Does Not Return a Message" do
  address = Messaging::Address.build
  message = Fixtures::Controls::Message.example

  actor_cls = Class.new do
    include Actor

    handle message do
      Object.new
    end
  end

  actor = actor_cls.new
  actor.extend Actor::Controls
  actor.next_message = message
  actor.address = address

  actor.start do
    break
  end

  test "Nothing is written" do
    refute actor.writer do
      written?
    end
  end
end
