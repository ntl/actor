module Actor
  module Messaging
    module Message
      def self.included cls
        cls.class_exec do
          extend MessageName
        end
      end

      def self.=== object
        if object.is_a? Symbol
          true
        else
          super
        end
      end

      def message_name
        Name.get self.class.name
      end

      module MessageName
        def message_name
          Name.get name
        end
      end
    end
  end
end
