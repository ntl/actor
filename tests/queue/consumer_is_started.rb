require_relative '../test_init'

context "Consumer starts reading a queue" do
  queue = Queue.new
  queue.tail = 11

  context do
    consumer = Queue::Consumer.build queue

    test "Position is set to tail of queue" do
      assert consumer.position == 11
    end

    test "Reference count for the tail position is incremented" do
      assert queue.consumer_positions[11] == 1
    end

    test "Consumers predicate returns true" do
      assert queue.consumers?
    end

    consumer.stop
  end

  context "Block form start method" do
    context do
      consumer = Queue::Consumer.start queue do |consumer|
        test "Position is set to tail of queue" do
          assert consumer.position == 11
        end

        test "Reference count for the tail position is incremented" do
          assert queue.consumer_positions[11] == 1
        end

        test "Consumers predicate returns true" do
          assert queue.consumers?
        end
      end

      test "Consumer is stopped automatically" do
        refute queue.consumers?
      end
    end

    context "An error is raised within the block" do
      consumer = nil
      
      begin
        Queue::Consumer.start queue do |_consumer|
          consumer = _consumer
          fail
        end
      rescue
      end

      test "Consumer is still stopped" do
        refute queue.consumers?
      end
    end
  end
end
