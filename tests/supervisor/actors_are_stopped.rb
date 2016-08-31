require_relative '../test_init'

context "Supervisor stops actors" do
  supervisor = Supervisor.new

  address_1, thread_1 = Controls::Actor::Example.start include: %i(thread)
  address_2, thread_2 = Controls::Actor::Example.start include: %i(thread)

  supervisor.add address_1, thread_1
  supervisor.add address_2, thread_2

  supervisor.stop

  [thread_1, thread_2].each_with_index do |thread, index|
    test "Actor ##{index + 1} is eventually stopped" do
      thread.join

      refute thread.alive?
    end
  end
end
