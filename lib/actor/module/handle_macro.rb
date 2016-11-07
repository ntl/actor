module Actor
  module Module
    module HandleMacro
      def handle message_pattern, &handler
        method_name = MethodName.get message_pattern

        define_method method_name, &handler
      end

      module MessageName
        PATTERN = %r{(?:\A|[a-z0-9])[A-Z]}

        def self.get message_const
          *, inner_namespace = message_const.split '::'

          inner_namespace.gsub! PATTERN do |str|
            str.downcase!
            str.insert 1, '_' if str.length == 2
            str
          end

          inner_namespace.to_sym
        end
      end

      module MethodName
        def self.get message_pattern
          case message_pattern
          when Symbol then
            :"handle_#{message_pattern}"

          when Class
            get message_pattern.name

          when String
            message_name = MessageName.get message_pattern
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
