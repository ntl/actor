require_relative '../test_init'

context "Error is raised, causing actor to crash" do
  error_cls = Class.new StandardError

  actor_cls = Class.new do
    include Actor

    define_method :action do
      raise error_cls
    end
  end

  _, actor, thread = actor_cls.start include: %i(actor thread)

  test "Error is reraised when thread is joined" do
    assert proc { thread.join } do
      raises_error? error_cls
    end
  end

  test "Actor state is set to crashed" do
    assert actor.state == :crashed
  end
end
