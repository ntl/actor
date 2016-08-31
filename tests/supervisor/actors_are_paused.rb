require_relative '../test_init'

context "Supervisor pauses actors" do
  supervisor = Supervisor.new

  address_1, thread_1 = Controls::Actor::Example.start include: %i(thread)
  address_2, thread_2 = Controls::Actor::Example.start include: %i(thread)

  supervisor.add address_1, thread_1
  supervisor.add address_2, thread_2

  supervisor.pause

  [address_1, address_2].each_with_index do |address, index|
    TestFixtures::SampleActorStatus.(
      "Actor ##{index + 1} is eventually paused",

      address: address,

      test: proc { |status|
        assert status.state == :paused
      }
    )
  end

  thread_1.kill
  thread_2.kill
end
