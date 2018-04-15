module Actor
  module Controls
    module Thread
      def self.terminate(thread, elapsed_time_limit: nil)
        elapsed_time_limit ||= self.elapsed_time_limit

        thread.kill

        wait_finished(thread)
      end

      def self.await_crash(thread, error=nil, elapsed_time_limit: nil)
        elapsed_time_limit ||= self.elapsed_time_limit

        thread.join(elapsed_time_limit)

        false

      rescue => join_error
        if error.nil? || error === join_error || error == join_error
          return true
        else
          raise join_error
        end
      end

      def self.await_finish(thread, elapsed_time_limit: nil)
        elapsed_time_limit ||= self.elapsed_time_limit

        thread.join(elapsed_time_limit)
      end

      def self.await_asleep(thread, elapsed_time_limit: nil)
        elapsed_time_limit ||= self.elapsed_time_limit

        t0 = Time.now

        until thread.status == Status.asleep
          t1 = Time.now

          elapsed_time = t1 - t0

          if elapsed_time > elapsed_time_limit
            fail "Elapsed time limit exceeded (Limit: #{elapsed_time_limit}, Elapsed Time: #{elapsed_time})"
          end

          Thread.pass
        end

        nil
      end

      def self.elapsed_time_limit
        0.1
      end
    end
  end
end
