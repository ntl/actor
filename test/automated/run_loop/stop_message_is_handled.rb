require_relative '../../test_init'

context "Actor Handles a Stop Message" do
  actor = Controls::Actor.example

  test "StopIteration error is raised" do
    assert_raises StopIteration do
      actor.handle_stop
    end
  end
end
