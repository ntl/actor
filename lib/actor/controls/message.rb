module Actor
  module Controls
    module Message
      def self.example
        attribute = Attribute.example

        Example.new attribute
      end

      module Other
        def self.example
          attribute = Attribute::Other.example

          Example.new attribute
        end
      end

      Example = Struct.new :some_attribute do
        include Messaging::Message
      end
    end
  end
end
