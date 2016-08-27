require_relative '../../test_init'

context "Thread synchronization between a writer and multiple readers" do
  queue = Queue.new

  object = Object.new

  iterations, _ = TestFixtures::ParallelIteration.(
    'All produced objects were read',

    setup: proc {
      queue.reader_started

      iteration_count.times do
        queue.write object
      end
    },

    teardown: proc {
      queue.reader_stopped 0
    },

    setup_thread: proc {
      thread[:reader] = Queue::Reader.build queue
    },

    each_iteration: proc {
      object_read = thread[:reader].read wait: true

      fail "Did not read object" unless object_read == object
    },

    test: proc {
      assert thread[:reader].position == iteration_count
    }
  )

  test "Queue is empty" do
    assert queue, &:empty?
    assert queue.tail == iterations
  end
end
