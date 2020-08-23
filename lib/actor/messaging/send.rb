module Actor
  module Messaging
    class Send
      def call message, queue, wait: nil
        non_block = !wait

        if message.instance_of? ::Module
          message = message.message_name
        end

        begin
          queue.enq message, non_block
        rescue ThreadError
          raise QueueFullError
        end
      end

      QueueFullError = Class.new StandardError

      def self.call *arguments
        instance = new
        instance.(*arguments)
      end
    end
  end
end
