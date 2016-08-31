require_relative '../test_init'

context "Supervisor resumes actors" do
  supervisor = Supervisor.new

  address_1, thread_1 = Controls::Actor::Example.spawn include: %i(thread)
  address_2, thread_2 = Controls::Actor::Example.spawn include: %i(thread)

  supervisor.add address_1, thread_1
  supervisor.add address_2, thread_2

  supervisor.resume

  [address_1, address_2].each_with_index do |address, index|
    TestFixtures::SampleActorStatus.(
      "Actor ##{index + 1} is eventually running",

      address: address,

      test: proc { |status|
        assert status.state == :running
      }
    )
  end

  thread_1.kill
  thread_2.kill
end
