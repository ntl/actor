module Actor
  class Queue
    module Assertions
      def contains? object
        if list.find object then true else false end
      end

      def empty?
        size.zero?
      end
    end
  end
end
