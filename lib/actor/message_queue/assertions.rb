module Actor
  class MessageQueue
    module Assertions
      def contains? message
        if list.find message then true else false end
      end

      def empty?
        size.zero?
      end
    end
  end
end
