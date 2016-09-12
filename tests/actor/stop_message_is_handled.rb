require_relative '../test_init'

context "Actor handles a stop message" do
  message = Messages::Stop.new
  actor = Controls::Actor.example

  test "Stop iteration exception is raised in order to break out of run loop" do
    assert proc { actor.handle message } do
      raises_error? StopIteration
    end
  end
end
