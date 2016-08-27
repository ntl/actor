require_relative '../test_init'

context "Execution count statistics" do
  statistics = Actor::Statistics.new

  test "Value is zero initially" do
    assert statistics.executions == 0
  end

  test "Value is increased by one after every action" do
    3.times do
      statistics.executing_action
      statistics.action_executed
    end

    assert statistics.executions == 3
  end
end
