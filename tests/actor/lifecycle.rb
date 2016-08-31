require_relative '../test_init'

context "Actor lifecycle" do
  address, thread, actor = Controls::Actor::Example.start include: %i(thread actor)
  thread.abort_on_exception = true

  writer = Messaging::Writer.build address

  context "Initial state" do
    TestFixtures::SampleActorStatus.(
      "Actor is running",
      address: address,
      test: proc { |status, initial_status|
        assert status.state == :running
        assert status.executions > initial_status.executions
      }
    )
  end

  context "Actor is sent a pause message" do
    writer.write Message::Pause.new

    TestFixtures::SampleActorStatus.(
      "Actor is paused",
      address: address,
      test: proc { |status, initial_status|
        assert status.state == :paused
        assert status.executions == initial_status.executions
      }
    )
  end

  context "Actor is sent a resume message" do
    writer.write Message::Resume.new

    TestFixtures::SampleActorStatus.(
      "Actor is running",
      address: address,
      test: proc { |status, initial_status|
        assert status.state == :running
        assert status.executions > initial_status.executions
      }
    )
  end

  context "Actor is sent a stop message" do
    writer.write Message::Stop.new

    test "Thread terminates" do
      thread.join
    end

    test "Actor is stopped" do
      assert actor.actor_state == :stopped
    end
  end
end
