require_relative '../test_init'

context "Actor lifecycle" do
  address, thread, actor = Controls::Actor::Example.start include: %i(thread actor)
  thread.abort_on_exception = true

  writer = Messaging::Writer.build address

  context "Initial state" do
    TestFixtures::SampleActorStatus.(
      "Actor is paused",
      address: writer,
      test: proc { |status|
        assert status.state == :paused
        assert status.executions == 0
      }
    )
  end

  context "Actor is sent a resume system message" do
    writer.write Messaging::SystemMessage::Resume.new

    TestFixtures::SampleActorStatus.(
      "Actor is running",
      address: writer,
      test: proc { |status, initial_status|
        assert status.state == :running
        assert initial_status.executions == 0
        assert status.executions > initial_status.executions
      }
    )
  end

  context "Actor is sent a pause system message" do
    writer.write Messaging::SystemMessage::Pause.new

    TestFixtures::SampleActorStatus.(
      "Actor is paused",
      address: writer,
      test: proc { |status, initial_status|
        assert status.state == :paused
        assert status.executions == initial_status.executions
      }
    )
  end

  context "Actor is sent a stop system message" do
    writer.write Messaging::SystemMessage::Stop.new

    test "Thread terminates" do
      thread.join
    end

    test "Actor is stopped" do
      assert actor.actor_state == :stopped
    end
  end
end
