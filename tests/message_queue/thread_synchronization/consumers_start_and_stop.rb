require_relative '../../test_init'

context "Thread synchronization for start and stop of consumers" do
  queue = MessageQueue.new

  iterations, _ = TestFixtures::ParallelIteration.(
    'Consumer started and stopped',

    each_iteration: proc {
      consumer = MessageQueue::Consumer.build queue
      consumer.stop
    }
  )

  test "All consumers have been stopped" do
    refute queue.consumers?
  end
end
