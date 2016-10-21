module Actor
  module Controls
    module Error
      def self.example
        Example.new
      end

      Example = Class.new StandardError
    end
  end
end
