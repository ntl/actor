module Actor
  module Messaging
    module Message
      def self.=== object
        if object.is_a? Symbol
          true
        else
          super
        end
      end
    end
  end
end
