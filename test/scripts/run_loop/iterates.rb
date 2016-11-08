require_relative '../scripts_init'

context "Run Loop Iterates" do
  message = Fixtures::Controls::Message.example

  actor = Fixtures::Controls::Actor::Example.new
  actor.reader.message = message

  actor.start do
    break
  end

  test "Actor handles next message written to queue" do
    assert actor do
      handled? message
    end
  end
end
