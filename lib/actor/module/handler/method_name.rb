module Actor
  module Module
    module Handler
      module MethodName
        def self.get message_pattern
          message_name = Messaging::Message::Name.get message_pattern

          :"handle_#{message_name}"
        end
      end
    end
  end
end
