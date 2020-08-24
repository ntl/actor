require_relative '../../test_init'

context "Supervisor Start Class Method" do
  supervisor_queue = :not_assigned

  Supervisor.start do |supervisor|
    Controls::Actor::StopsImmediately.start
  end
end
