module Actor
  module Messaging
    module Message
      module Name
        PATTERN = %r{(?:\A|[a-z0-9])[A-Z]}

        def self.get value
          case value
          when Symbol
            value

          when ::Module, Class
            get value.name

          when String
            *, inner_namespace = value.split '::'

            inner_namespace.gsub! PATTERN do |str|
              str.downcase!
              str.insert 1, '_' if str.length == 2
              str
            end

            inner_namespace.to_sym

          else
            get value.class
          end
        end
      end
    end
  end
end
