require_relative '../test_init'

context "Copying statistics to a another object" do
  statistics = Controls::Statistics.example
  target = OpenStruct.new

  Statistics::Copy.(target, statistics)

  test "Average elapsed time is copied" do
    assert target.average_elapsed_time == statistics.average_elapsed_time
  end

  test "Elapsed time is copied" do
    assert target.elapsed_time == statistics.elapsed_time
  end

  test "Execution count is copied" do
    assert target.executions == statistics.executions
  end

  test "Last execution time is copied" do
    assert target.last_execution_time == statistics.last_execution_time
  end

  test "Minimum elapsed time is copied" do
    assert target.minimum_elapsed_time == statistics.minimum_elapsed_time
  end

  test "Maximum elapsed time is copied" do
    assert target.maximum_elapsed_time == statistics.maximum_elapsed_time
  end

  test "Start time is copied" do
    assert target.start_time == statistics.start_time
  end

  test "Standard deviation of elapsed time is copied" do
    deviation, _, _, percent = statistics.standard_deviation

    assert target.standard_deviation_amount == deviation
    assert target.standard_deviation_percent == percent
  end
end
