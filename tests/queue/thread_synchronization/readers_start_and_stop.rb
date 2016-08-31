require_relative '../../test_init'

context "Thread synchronization for start and stop of reader" do
  queue = Actor::Queue.new

  TestFixtures::ParallelIteration.(
    'Reader started and stopped',

    each_iteration: proc {
      reader = Actor::Queue::Reader.build queue
      reader.stop
    }
  )

  test "All readers have been stopped" do
    refute queue.readers?
  end
end
