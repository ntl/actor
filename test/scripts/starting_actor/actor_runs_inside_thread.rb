require_relative '../../test_init'

context "Actor Runs Inside Thread When Started" do
  actor_cls = Class.new do
    include Actor

    attr_accessor :thread

    handle Messages::Start do
      self.thread = Thread.current and raise StopIteration
    end
  end

  actor, thread = Start.(actor_cls)

  thread.join

  test "Thread assigned to actor differs from the thread that started said actor" do
    refute thread == Thread.main
  end

  test "Run loop is executed within thread assigned to actor" do
    assert actor.thread == thread
  end
end
