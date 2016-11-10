require_relative '../../test_init'

context "Actor Handles a Stop Message" do
  stop_message = Messages::Stop

  actor = Fixtures::Controls::Actor.example

  test "StopIteration error is raised" do
    assert proc { actor.handle stop_message } do
      raises_error? StopIteration
    end
  end
end
