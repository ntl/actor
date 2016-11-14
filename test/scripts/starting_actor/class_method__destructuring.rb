require_relative '../../test_init'

context "Actor is Started Via Class Method, Destructuring" do
  actor_class = Controls::Actor::StopsImmediately

  context "Actor instance is specified to be returned" do
    _, actor = actor_class.start include: :actor

    test "Actor instance is also returned" do
      assert actor do
        instance_of? actor_class
      end
    end
  end

  context "Thread is specified to be returned" do
    _, thread = actor_class.start include: :thread

    test "Thread is also returned" do
      refute thread == Thread.current

      assert thread do
        instance_of? ::Thread
      end
    end
  end

  context "Both actor instance and thread are specified to be returned" do
    _, actor, thread = actor_class.start include: [:actor, :thread]

    test "Thread and actor instance are also returned" do
      assert actor do
        instance_of? actor_class
      end

      refute thread == Thread.current

      assert thread do
        instance_of? ::Thread
      end
    end
  end
end
