require_relative '../scripts_init'

context "Stream Read Operation, Buffer is Not Empty" do
  stream = Stream.new
  stream.extend Stream::Controls

  context "Multiple threads are reading simultaneously" do
    buffer = Controls::Buffer::Incrementing.new

    Fixtures::ParallelExecute.(
      setup: proc { |_, thread_count|
        stream.buffer = buffer

        thread_count.times do
          stream.start_reader
        end
      },

      action: proc { |cycle|
        message = stream.read cycle.thread_iteration

        unless message == cycle.thread_iteration
          fail "Message was read out of order (Message: #{message}, ThreadIteration: #{cycle.thread_iteration})"
        end
      },

      test: proc { |_, threads|
        min_thread_position = threads.each_value.min

        test "Messages before the furthest behind thread are removed from buffer" do
          assert buffer do
            gc_count? min_thread_position
          end
        end
      }
    )
  end
end
