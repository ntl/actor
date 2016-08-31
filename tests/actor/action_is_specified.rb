require_relative '../test_init'

context "Action is specified by actor implementation" do
  address, actor, thread = Controls::Actor::Example.start include: %i(actor thread)

  TestFixtures::SampleActorStatus.(
    "Action is executed",
    address: address,
    test: proc {
      assert actor.action_executed?
    }
  )

  Messaging::Writer.write Message::Stop.new, address

  thread.join

  test "Action is executed" do
    assert actor.action_executed?
  end
end
