module Actor
  module Controls
    module Error
      def self.example
        Example.new(message)
      end

      def self.message
        'Some Error'
      end

      Example = Class.new(StandardError)
    end
  end
end
