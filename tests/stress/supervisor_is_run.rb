require_relative '../test_init'

context "Supervisor is run" do
  Stress.times do |iteration|
    test "Iteration ##{iteration + 1}" do
      actors_remaining = 10

      Supervisor.run do |supervisor|
        supervisor.observe :actor_started do
          actors_remaining -= 1
        end

        actors_remaining.times do
          Controls::Actor::Example.start
        end

        Messaging::Write.(:shutdown, supervisor.address)
      end

      assert actors_remaining == 0
    end
  end
end
