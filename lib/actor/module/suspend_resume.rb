module Actor
  module Module
    module SuspendResume
      def self.included cls
        cls.class_exec do
          prepend Configure
          prepend Handle
          prepend Initialize

          IncludeAssertions.(Assertions, self)
        end
      end

      attr_accessor :suspended
      attr_writer :suspend_queue

      def handle_suspend
        self.suspended = true
      end

      def handle_resume
        self.suspended = false

        until suspend_queue.empty?
          deferred_message = suspend_queue.deq

          write.(deferred_message, address)
        end
      end

      def suspend_queue
        @suspend_queue ||= Messaging::Queue::Substitute.build
      end
    end
  end
end
