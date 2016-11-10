require_relative '../../test_init'

context "Supervisor is Constructed Within a Non-Default Thread Group" do
  supervisor = nil

  thread_group = ThreadGroup.new

  thread = Thread.new do
    thread_group.add Thread.current
    supervisor = Build.(Supervisor)
    sleep
  end
  Thread.pass until thread.stop?

  test "Thread group is set to that of thread in which supervisor is built" do
    assert supervisor.thread_group == thread_group
  end

  thread.kill
end
