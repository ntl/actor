module Actor
  module Module
    module Digest
      def digest
        "#{self.class}[queue=#{queue}]"
      end
    end
  end
end
