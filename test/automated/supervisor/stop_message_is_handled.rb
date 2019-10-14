require_relative '../../test_init'

context "Supervisor Handles Stop Message" do
  supervisor = Supervisor.new

  test "Run loop is stopped" do
    assert_raises StopIteration do
      supervisor.handle Messages::Stop
    end
  end

  context "Error is set" do
    supervisor.error = Controls::Error.example

    test "Error is reraised" do
      assert_raises Controls::Error::SomeError do
        supervisor.handle Messages::Stop
      end
    end
  end
end
