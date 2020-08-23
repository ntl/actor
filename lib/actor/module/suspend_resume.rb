module Actor
  module Module
    module SuspendResume
      def self.included cls
        cls.class_exec do
          prepend Configure
          prepend Handle
          prepend Initialize
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

          send.(deferred_message, queue)
        end
      end

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

      def suspend_queue
        @suspend_queue ||= Messaging::Queue::Substitute.build
      end
    end
  end
end
