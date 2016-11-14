module Actor
  module Module
    module SuspendResume
      module Assertions
        def message_deferred? message=nil, wait: nil
          non_block = wait == false

          begin
            msg = suspend_queue.deq true
          rescue ThreadError
          end

          if message.nil?
            msg ? true : false
          else
            msg == message
          end
        end

        def suspended?
          @suspended == true
        end
      end
    end
  end
end
