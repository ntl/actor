require_relative '../test_init'

context "Start message is handled by a supervisor" do
  start = Messages::Start.new

  supervisor = Supervisor.new
  return_value = supervisor.handle start

  test "Continue message is returned" do
    assert return_value.instance_of? Supervisor::Continue
  end
end
