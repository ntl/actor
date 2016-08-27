require_relative '../test_init'

context "Start time statistics" do
  statistics = Actor::Statistics.new
  statistics.timer = Controls::Statistics::Timer.example

  test "Value is nil initially" do
    assert statistics.start_time.nil?
  end

  test "Value is set to current time the first time the action is taken" do
    statistics.executing_action

    assert statistics.start_time == Controls::Time.reference
  end

  test "Value is unchanged by subsequent actions" do
    statistics.executing_action

    assert statistics.start_time == Controls::Time.reference
  end
end
