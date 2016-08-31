require_relative '../test_init'

context "Signals are trapped by supervisor" do
  supervisor = Supervisor.new

  address, thread = Controls::Actor::Example.spawn include: %i(thread)

  supervisor.add address, thread

  context "SIGCONT" do
    Process.kill 'CONT', Process.pid

    TestFixtures::SampleActorStatus.(
      'Supervised actor is resumed',
      address: address,
      test: proc { |status| status.state == :running }
    )
  end

  context "SIGTSTP" do
    Process.kill 'TSTP', Process.pid

    TestFixtures::SampleActorStatus.(
      'Supervised actor is paused',
      address: address,
      test: proc { |status| status.state == :paused }
    )
  end

  context "SIGINT" do
    Process.kill 'INT', Process.pid

    TestFixtures::SampleActorStatus.(
      'Supervised actor is stopped',
      address: address,
      test: proc { |status| status.state == :stopped }
    )
  end
end
