require_relative '../test_init'

context "Start message is handled by a supervisor" do
  start = Messages::Start.new

  context do
    supervisor = Supervisor.new
    return_value = supervisor.handle start

    test "Continue message is returned" do
      assert return_value == :continue
    end

    test "Current thread is added to thread group" do
      assert supervisor.thread_group do
        list.include? Thread.current
      end
    end

    test "Thread group is enclosed" do
      assert supervisor.thread_group do
        enclosed?
      end
    end
  end

  context "Assembly block is specified" do
    block_executed = false

    supervisor = Supervisor.new do
      block_executed = true
    end

    supervisor.handle start

    test "Assembly block is executed" do
      assert block_executed
    end
  end
end
