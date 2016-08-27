require_relative '../../test_init'

context "Thread synchronization for consuming" do
  queue = Queue.new

  object = Object.new

  iterations, threads = TestFixtures::ParallelIteration.(
    'All objects are consumed',

    setup: proc {
      queue.consumer_started
      queue.write object
    },

    teardown: proc {
      queue.consumer_stopped 0
    },

    each_iteration: proc {
      position = queue.consumer_started

      object_read = queue.read position

      fail "Did not read object" unless object_read == object
    },
  )

  test "Tail is advanced" do
    assert queue.tail == 1
  end
end
