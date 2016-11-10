module Actor
  module Module
    def self.included cls
      cls.class_exec do
        extend HandleMacro
      end
    end

    include Messaging::Address::Dependency
    include Messaging::Reader::Dependency
    include Messaging::Writer::Dependency

    def handle message
      handler_method_name = HandleMacro::MethodName.get message

      return unless handler_method_name and respond_to? handler_method_name

      handler_method = method handler_method_name

      if handler_method.arity == 0
        handler_method.()
      else
        handler_method.(message)
      end
    end

    def start &supplemental_action
      loop do
        message = reader.read

        next_message = handle message

        if Messaging::Message === next_message
          writer.write next_message, address
        end

        break
      end
    end
  end
end
