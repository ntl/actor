module Actor
  module Messaging
    class Writer
      def write message, address, wait: nil
        non_block = wait == false

        queue = address.queue

        begin
          queue.enq message, non_block
        rescue ThreadError
          raise WouldBlockError
        end
      end

      WouldBlockError = Class.new StandardError
    end
  end
end
