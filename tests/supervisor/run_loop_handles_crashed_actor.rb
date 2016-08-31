require_relative '../test_init'

context "Supervisor run loop handles an actor that has crashed" do
  address, thread = Controls::Actor::CrashesImmediately.start include: %i(thread)

  error = nil

  supervisor = Supervisor.new
  supervisor.add address, thread
  supervisor.exception_notifier = proc { |_error| error = _error }

  test "Error is re-raised by supervisor" do
    assert proc { supervisor.start } do
      raises_error? Controls::Actor::CrashesImmediately::Error
    end
  end

  test "Exception notifier is actuated" do
    assert error.instance_of? Controls::Actor::CrashesImmediately::Error
  end
end
