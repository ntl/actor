require_relative '../../test_init'

context "Thread synchronization between a producer and multiple consumers" do
  queue = Queue.new

  object = Object.new

  iterations, _ = TestFixtures::ParallelIteration.(
    'All produced objects were consumed',

    setup: proc {
      queue.consumer_started

      iteration_count.times do
        queue.write object
      end
    },

    teardown: proc {
      queue.consumer_stopped 0
    },

    setup_thread: proc {
      thread[:consumer] = Queue::Consumer.build queue
    },

    each_iteration: proc {
      object_read = thread[:consumer].next wait: true

      fail "Did not read object" unless object_read == object
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
