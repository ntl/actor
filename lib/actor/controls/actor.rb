module Actor
  module Controls
    module Actor
      def self.example
        Example.new
      end

      class Example
        include ::Actor
      end
    end
  end
end
