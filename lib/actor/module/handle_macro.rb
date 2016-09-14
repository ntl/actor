module Actor
  module Module
    module HandleMacro
      def handle_macro pattern, &action
        method_name = MethodName.get pattern

        define_method method_name, &action
      end
      alias_method :handle, :handle_macro

      module MethodName
        PATTERN = %r{(?:\A|[a-z0-9])[A-Z]}

        def self.get message_pattern
          case message_pattern
          when Class, String then
            message_name = message_pattern.to_s

            *, message_name = message_name.split '::'

            message_name.gsub! PATTERN do |str|
              str.downcase!
              str.insert 1, '_' if str.length == 2
              str
            end

            get message_name.to_sym

          when Symbol then
            :"handle_#{message_pattern}"

          else
            get message_pattern.class
          end
        end
      end
    end
  end
end
