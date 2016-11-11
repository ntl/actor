require_relative '../../test_init'

context "Supervisor Handles Resume Message" do
  supervisor = Supervisor.new

  supervisor.handle Messages::Resume

  test "Suspend is published to all actors" do
    assert supervisor.publisher do
      published? Messages::Resume
    end
  end
end
