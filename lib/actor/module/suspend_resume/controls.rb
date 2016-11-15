module Actor
  module Module
    module SuspendResume
      module Controls
        def suspend!
          self.suspended = true
        end

        def defer_message *messages
          messages.each do |message|
            suspend_queue.enq message
          end
        end
      end
    end
  end
end
