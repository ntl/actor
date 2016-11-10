module Actor
  module Messaging
    module Message
      module Name
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
    end
  end
end
