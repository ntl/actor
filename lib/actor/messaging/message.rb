module Actor
  module Messaging
    module Message
      def self.included cls
        cls.class_exec do
          extend Matcher

          include MessageName
        end
      end

      def self.extended receiver
        receiver.instance_exec do
          extend Matcher
          extend MessageName
        end
      end

      def self.=== object
        if object.is_a?(Symbol)
          true
        else
          super
        end
      end

      module Matcher
        def === other
          other_message_name = Name.get(other)

          message_name == other_message_name
        end
      end

      module MessageName
        def self.included(cls)
          cls.class_exec do
            extend ClassMethod

            include InstanceMethod
          end
        end

        def self.extended(receiver)
          receiver.extend(ClassMethod)
        end

        module InstanceMethod
          def message_name
            self.class.message_name
          end
        end

        module ClassMethod
          def message_name
            Name.get(name)
          end
        end
      end
    end
  end
end
