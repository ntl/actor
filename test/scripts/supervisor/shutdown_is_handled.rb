require_relative '../../test_init'

context "Supervisor Handles Shutdown Message" do
  supervisor = Supervisor.new

  supervisor.handle Messages::Shutdown

  test "Stop is published to all actors" do
    assert supervisor.publisher do
      published? Messages::Stop
    end
  end
end
