require_relative '../../test_init'

context "Actor is Started Via Class Method, Destructuring" do
  actor_class = Controls::Actor::StopsImmediately

  context "Thread is specified to be returned" do
    _, thread = actor_class.start include: :thread

    test "Thread is also returned" do
      refute thread == Thread.current

      assert thread.instance_of?(::Thread)
    end
  end
end
