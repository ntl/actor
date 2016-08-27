require_relative '../../test_init'

context "Thread synchronization for reading" do
  queue = Queue.new

  object = Object.new

  iterations, threads = TestFixtures::ParallelIteration.(
    'All objects are read',

    setup: proc {
      queue.reader_started
      queue.write object
    },

    teardown: proc {
      queue.reader_stopped 0
    },

    each_iteration: proc {
      position = queue.reader_started

      object_read = queue.read position

      fail "Did not read object" unless object_read == object
    },
  )

  test "Tail is advanced" do
    assert queue.tail == 1
  end
end
