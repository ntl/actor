module TestBench
  class Result
    module Null
      def self.method_missing *;
      end

      def self.respond_to? _
        true
      end
    end
  end
end
