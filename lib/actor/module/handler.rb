module Actor
  module Module
    module Handler
      def self.included cls
        cls.class_exec do
          extend Macro
        end
      end

      def handle message
        handler_method_name = MethodName.get message

        return unless handler_method_name and respond_to? handler_method_name

        handler_method = method handler_method_name

        if handler_method.arity == 0
          return_value = handler_method.()
        else
          return_value = handler_method.(message)
        end

        if Messaging::Message === return_value
          writer.write return_value, address
        end

        return_value
      end
    end
  end
end
