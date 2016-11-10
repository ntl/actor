module Actor
  module Module
    module HandleMacro
      def handle message_pattern, &handler
        method_name = MethodName.get message_pattern

        define_method method_name, &handler
      end

      module MethodName
        def self.get message_pattern
          case message_pattern
          when Symbol then
            :"handle_#{message_pattern}"

          when Class
            get message_pattern.name

          when String
            message_name = Messaging::Message::Name.get message_pattern
            get message_name

          when NilClass
            nil

          else Object
            get message_pattern.class
          end
        end
      end
    end
  end
end
