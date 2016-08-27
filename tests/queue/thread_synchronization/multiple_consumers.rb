require_relative '../../test_init'

context "Thread synchronization between a producer and multiple consumers" do
  queue = Queue.new

  message = 'some-message'

  iterations, _ = TestFixtures::ParallelIteration.(
    'All produced messages were consumed',

    setup: proc {
      queue.consumer_started

      iteration_count.times do
        queue.write message
      end
    },

    teardown: proc {
      queue.consumer_stopped 0
    },

    setup_thread: proc {
      thread[:consumer] = Queue::Consumer.build queue
    },

    each_iteration: proc {
      read_message = thread[:consumer].next block: true

      unless read_message == message
        fail "Did not read message; read #{read_message.inspect}"
      end
    },

    test: proc {
      assert thread[:consumer].position == iteration_count
    }
  )

  test "Queue is empty" do
    assert queue, &:empty?
    assert queue.tail == iterations
  end
end
