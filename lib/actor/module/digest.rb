module Actor
  module Module
    module Digest
      def digest
        "#{self.class}[address=#{address}]"
      end
    end
  end
end
