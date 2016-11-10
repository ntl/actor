module Actor
  module Module
    module Handler
      module Macro
        def handle message_pattern, &handler
          method_name = MethodName.get message_pattern

          define_method method_name, &handler
        end
      end
    end
  end
end
