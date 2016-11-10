require_relative '../../test_init'

context "StopIteration is Raised When Run Loop Iterates" do
  message = Fixtures::Controls::Message.example

  actor = Fixtures::Controls::Actor.define_singleton do
    handle message do
      raise StopIteration
    end
  end

  actor.next_message = message

  Fixtures::Timeout.("Run loop does not run indefinitely") do
    actor.run_loop
  end
end
