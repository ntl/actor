require_relative '../test_init'

context "Supervisor address registry" do
  supervisor = Supervisor.new

  address, thread = Controls::Actor::Example.spawn include: %i(thread)

  context "Address of an actor is added" do
    supervisor.add address, thread

    test "Address is present in registry" do
      assert supervisor do actor? address end
    end
  end

  context "Address is removed" do
    supervisor.remove address

    test "Address is no longer present in registry" do
      refute supervisor do
        actor? address
      end
    end
  end
end
