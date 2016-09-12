module Actor
  module Substitutes
    class Thread
      attr_accessor :name
      attr_accessor :priority
      attr_accessor :status

      def initialize
        @status = 'run'
        @priority = 0
      end

      def alive?
        %w(sleep run).include? status
      end

      def stop?
        status != 'run'
      end
    end
  end
end
