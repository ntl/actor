require_relative '../scripts_init'

context "Stream Read Operation" do
  stream = Stream.new
  stream.extend Stream::Controls

  context "Multiple threads are reading simultaneously" do
    per_thread_results = Hash.new do |hash, key|
      hash[key] = []
    end

    Fixtures::ParallelExecute.(
      setup: proc { |duration, thread_count|
        max_messages = duration * Rational(1_000_000, thread_count)

        comment "Messages needed for 1m ops/sec over #{thread_count} threads: #{max_messages.to_i}"
        stream.buffer = (0..max_messages).to_a
      },

      action: proc { |cycle|
        message = stream.read cycle.thread_iteration

        per_thread_results[cycle.thread] << message
      },

      test: proc { |_, threads|
        threads.each do |thread, iterations|
          expected = (0...iterations).to_a

          test "Thread ##{thread} read every message exactly once" do
            assert per_thread_results[thread] == expected
          end
        end
      }
    )
  end
end
