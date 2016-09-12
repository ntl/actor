module Actor
  module Substitutes
    class ThreadGroup
      def initialize
        @list = []
        @enclosed = false
      end

      def add thread
        @list << thread
      end

      def list
        @list.dup
      end

      def enclose
        @enclosed = true
      end

      def enclosed?
        @enclosed
      end
    end
  end
end
