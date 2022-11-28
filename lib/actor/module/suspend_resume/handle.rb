module Actor
  module Module
    module SuspendResume
      module Handle
        def handle(message)
          self.suspended = false if Messages::Resume === message

          if suspended
            suspend_queue.enq(message, true)
          else
            super
          end
        end
      end
    end
  end
end
