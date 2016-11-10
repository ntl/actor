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
        if instance_of? ::Module
          message_const = name
        else
          message_const = self.class.name
        end

        Name.get message_const
      end

      module MessageName
        def message_name
          Name.get name
        end
      end
    end
  end
end
