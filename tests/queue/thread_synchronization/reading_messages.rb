require_relative '../../test_init'

context "Thread synchronization for reading messages" do
  queue = Queue.new

  message = 'some-message'

  iterations, threads = TestFixtures::ParallelIteration.(
    'All messages are read',

    setup: proc {
      queue.consumer_started
      queue.write message
    },

    teardown: proc {
      queue.consumer_stopped 0
    },

    each_iteration: proc {
      position = queue.consumer_started

      read_message = queue.read position

      unless read_message == message
        fail "Did not read message; read #{read_message.inspect}"
      end
    },
  )

  test "All messages were read" do
    assert queue.tail == 1
  end
end
