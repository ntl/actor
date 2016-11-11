require_relative '../../test_init'

context "Run Loop Iterates" do
  message = Fixtures::Controls::Message.example

  actor = Fixtures::Controls::Actor::Example.new
  actor.next_message = message

  actor.run_loop do
    break
  end

  test "Actor handles next message written to queue" do
    assert actor do
      handled? message
    end
  end
end
