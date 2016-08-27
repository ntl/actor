require_relative '../test_init'

context "Standard deviation of elapsed time statistics" do
  statistics = Actor::Statistics.new

  test "Value is unknown initially" do
    assert statistics.standard_deviation == nil
  end

  context "Value is updated each time the action is taken" do
    iteration_count = Controls::Statistics::ElapsedTime::StandardDeviation.configure_timer statistics

    iteration_count.times do
      statistics.executing_action
      statistics.action_executed
    end


    deviation, minimum, maximum, percent = statistics.standard_deviation

    test "Deviation" do
      assert deviation == Controls::Statistics::ElapsedTime::StandardDeviation.value
    end

    test "Maximum" do
      assert maximum == Controls::Statistics::ElapsedTime::StandardDeviation.maximum
    end

    test "Minimum" do
      assert minimum == Controls::Statistics::ElapsedTime::StandardDeviation.minimum
    end

    test "Percentage of average" do
      assert percent == Controls::Statistics::ElapsedTime::StandardDeviation.percent
    end
  end
end
