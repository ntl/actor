require_relative '../scripts_init'

context "Stream Write Operation" do
  stream = Stream.new

  context "Multiple threads are writing simultaneously" do
    Fixtures::ParallelExecute.(
      action: proc { |cycle|
        stream.write cycle.global_iteration
      },

      test: proc { |total_iterations, threads|
        test "Each thread wrote every message exactly once" do
          assert stream do
            buffer? do |buffer|
              messages_by_thread = Hash.new do |hash, thread|
                hash[thread] = []
              end

              buffer.sort.each do |i|
                messages_by_thread[i % threads.count] << i
              end

              threads.all? do |thread, iterations|
                first_value = thread
                last_value = first_value + iterations.pred * threads.count

                actual = messages_by_thread[thread]
                expected = (first_value..last_value).step(threads.count).to_a

                actual == expected
              end
            end
          end
        end
      }
    )
  end
end
