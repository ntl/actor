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
          handler_method.()
        else
          handler_method.(message)
        end
      end
    end
  end
end
