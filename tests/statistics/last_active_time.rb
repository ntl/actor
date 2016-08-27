require_relative '../test_init'

context "Last active time statistics" do
  statistics = Actor::Statistics.new
  statistics.timer = Controls::Statistics::Timer.example

  test "Value is unknown initially" do
    assert statistics.last_execution_time.nil?
  end

  test "Value is set to current time when the action is taken" do
    3.times do
      statistics.executing_action
      statistics.action_executed
    end

    assert statistics.last_execution_time == Controls::Time.example(3)
  end
end
