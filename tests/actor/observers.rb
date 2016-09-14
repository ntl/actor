require_relative '../test_init'

context "Actor observers" do
  notified_counter = 0

  actor = Controls::Actor.example

  observer = actor.observe :example do
    notified_counter += 1
  end

  context "Observer is registered for a message pattern" do
    actor.handle Controls::Message.example

    test "Handling any message matching specified pattern actuates callback" do
      assert notified_counter == 1
    end
  end

  context "Observer is unregistered for a message pattern" do
    actor.remove_observer observer

    actor.handle Controls::Message.example

    test "Handling any message matching specified pattern no longer actuates callback" do
      assert notified_counter == 1
    end
  end
end
