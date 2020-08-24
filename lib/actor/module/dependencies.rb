module Actor
  module Module
    module Dependencies
      def self.included receiver
        receiver.class_exec do
          include Messaging::Queue::Dependency
          include Messaging::Read::Dependency
          include Messaging::Send::Dependency

          prepend Configure
        end
      end

      def configure
      end

      def dependencies_configured?
        queue_configured? and reader_configured? and send_configured?
      end

      def queue_configured?
        queue.instance_of?(SizedQueue)
      end

      def reader_configured?
        read.instance_of?(Messaging::Read)
      end

      def send_configured?
        send.instance_of?(Messaging::Send)
      end

      module Configure
        def configure(actor_queue: nil)
          actor_queue ||= Messaging::Queue.get

          self.queue = actor_queue
          self.read = Messaging::Read.build(self.queue)
          self.send = Messaging::Send.new

          super()
        end
      end
    end
  end
end
