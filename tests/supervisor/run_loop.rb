require_relative '../test_init'

context "Supervisor run loop" do
  supervisor = Supervisor.new

  address_1, thread_1 = Controls::Actor::Example.start include: %i(thread)
  address_2, thread_2 = Controls::Actor::Example.start include: %i(thread)

  supervisor.add address_1, thread_1
  supervisor.add address_2, thread_2

  test "Run loop continues to iterate as long as all actor threads are alive" do
    counter = 0

    stop_message = Actor::Message::Stop.new

    supervisor.start do
      counter += 1

      Actor::Messaging::Writer.(stop_message, address_1) if counter == 1
      Actor::Messaging::Writer.(stop_message, address_2) if counter == 11
    end

    refute thread_1.alive?
    refute thread_2.alive?
    assert supervisor.actors.empty?
    assert counter >= 11
  end
end
