require_relative '../test_init'

context "Destructuring the artifacts instantiated by starting" do
  actor = Controls::Actor.example
  address = Messaging::Address.get
  thread = Thread.current

  test "Address is returned by default" do
    control_address = address

    address = Controls::Actor::Example.destructure actor, control_address, thread

    assert address == control_address
  end

  context "Thread is requested" do
    control_thread = thread

    _, thread = Controls::Actor::Example.destructure actor, address, control_thread, include: %i(thread)

    test "Thread is returned" do
      assert thread == control_thread
    end
  end

  context "Actor is requested" do
    control_actor = actor

    _, actor = Controls::Actor::Example.destructure control_actor, address, thread, include: %i(actor)

    test "Actor is returned" do
      assert actor == control_actor
    end
  end

  context "Both the thread and the actor are requested" do
    control_thread = thread
    control_actor = actor

    _, actor, thread = Controls::Actor::Example.destructure control_actor, address, thread, include: %i(actor thread)

    test "Actor is returned" do
      assert actor == control_actor
    end

    test "Thread is returned" do
      assert thread == control_thread
    end
  end
end
