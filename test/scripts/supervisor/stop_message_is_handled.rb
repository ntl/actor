require_relative '../../test_init'

context "Supervisor Handles Stop Message" do
  supervisor = Supervisor.new

  test "Run loop is stopped" do
    assert proc { supervisor.handle Messages::Stop } do
      raises_error? StopIteration
    end
  end

  context "Error is set" do
    supervisor.error = Controls::Error.example

    test "Error is reraised" do
      assert proc { supervisor.handle Messages::Stop } do
        raises_error? Controls::Error::SomeError
      end
    end
  end
end
