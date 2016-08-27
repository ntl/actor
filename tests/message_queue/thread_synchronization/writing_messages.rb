require_relative '../../test_init'

context "Thread synchronization for writing messages" do
  queue = MessageQueue.new

  message = 'some-message'

  iterations, threads = TestFixtures::ParallelIteration.(
    'All messages are written',

    setup: proc {
      queue.consumer_started
    },

    each_iteration: proc {
      queue.write message
    },
  )

  test "Queue contains all messages written by all threads" do
    assert queue.size == iterations * threads
  end
end
