require_relative '../../test_init'

context "Run Loop Handles a Message, Handler Does Not Return a Message" do
  message = Fixtures::Controls::Message.example

  actor = Fixtures::Controls::Actor.define_singleton do
    handle message do
      Object.new
    end
  end

  actor.next_message = message

  actor.run_loop do
    break
  end

  test "Nothing is written" do
    refute actor.writer do
      written?
    end
  end
end
