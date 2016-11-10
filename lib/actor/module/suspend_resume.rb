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

      attr_writer :suspend_queue

      def handle_suspend
        @suspended = true
      end

      def suspend_queue
        @suspend_queue ||= Messaging::Queue::Substitute.build
      end
      private :suspend_queue

      module Initialize
        def initialize *;
          @suspended = false

          super
        end
      end

      module Configure
        def configure
          self.suspend_queue = Messaging::Queue.get

          super
        end
      end

      module Handle
        def handle message
          if @suspended
            suspend_queue.enq message, true
          end

          super
        end
      end
    end
  end
end
