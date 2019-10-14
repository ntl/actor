require_relative '../../test_init'

context "Run Loop Iterates when Queue is Empty" do
  actor = Controls::Actor::Example.new

  test "Actor waits for reader to receive incoming message" do
    assert_raises Messaging::Queue::Substitute::WouldBlockError do
      actor.run_loop
    end
  end
end
