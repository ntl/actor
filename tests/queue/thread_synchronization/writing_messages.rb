require_relative '../../test_init'

context "Thread synchronization for writing objects" do
  queue = Actor::Queue.new

  iterations, threads = TestFixtures::ParallelIteration.(
    'All objects are written',

    setup: proc {
      queue.reader_started
    },

    each_iteration: proc {
      queue.write Object.new
    }
  )

  test "Queue contains all objects written by all threads" do
    assert queue.size == iterations * threads
  end
end
