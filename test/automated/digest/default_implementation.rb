require_relative '../../test_init'

context "Digest, Default Implementation" do
  queue = Controls::Queue.example
  actor = Controls::Actor.example queue

  test "Queue is printed" do
    assert actor.digest == "#{actor.class}[queue=#{queue}]"
  end
end
