require_relative '../scripts_init'

context "Run Loop Handles a Message, Handler Returns New Message" do
  address = Messaging::Address.build
  message = Fixtures::Controls::Message.example

  actor = Fixtures::Controls::Actor::Example.new
  actor.next_message = message
  actor.address = address

  actor.run_loop do
    break
  end

  test "Message is written to address of actor" do
    assert actor.writer do
      written? message, address: address
    end
  end
end
