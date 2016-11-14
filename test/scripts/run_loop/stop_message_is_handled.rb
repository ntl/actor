require_relative '../../test_init'

context "Actor Handles a Stop Message" do
  actor = Controls::Actor.example

  test "StopIteration error is raised" do
    assert proc { actor.handle_stop } do
      raises_error? StopIteration
    end
  end
end
