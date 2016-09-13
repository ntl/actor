module Actor
  module Substitutes
    class Thread
      attr_reader :block
      attr_accessor :name
      attr_accessor :priority
      attr_accessor :status

      def initialize &block
        @status = 'run'
        @priority = 0

        @block = block
      end

      def join limit=nil
        if limit
          begin
            Timeout.timeout limit, &block
          rescue Timeout::Error
            return nil
          end
        else
          block.()
        end

        self
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
