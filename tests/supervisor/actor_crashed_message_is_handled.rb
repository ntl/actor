require_relative '../test_init'

context "Actor crashed message is handled by supervisor" do
  actor_crashed = Controls::Message::ActorCrashed.example

  supervisor = Supervisor.new
  return_value = supervisor.handle actor_crashed

  test "Error is set on supervisor" do
    assert supervisor.error == Controls::Error.example
  end

  test "Shutdown message is returned" do
    assert return_value == :shutdown
  end
end
