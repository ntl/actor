require_relative '../test_init'

context "Maximum elapsed time statistics" do
  statistics = Actor::Statistics.new

  test "Value is unknown initially" do
    assert statistics.maximum_elapsed_time == nil
  end

  test "Value is updated each time the action is taken" do
    iteration_count = Controls::Statistics::ElapsedTime::Maximum.configure_timer statistics

    iteration_count.times do
      statistics.executing_action
      statistics.action_executed
    end


    assert statistics.maximum_elapsed_time == Controls::Statistics::ElapsedTime::Maximum.value
  end
end
