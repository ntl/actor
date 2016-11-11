require_relative '../../test_init'

context "Supervisor Handles Suspend Message" do
  supervisor = Supervisor.new

  supervisor.handle Messages::Suspend

  test "Suspend is published to all actors" do
    assert supervisor.publisher do
      published? Messages::Suspend
    end
  end
end
