module Fixtures
  class Timeout
    include TestBench::Fixture

    attr_reader :block
    attr_reader :duration
    attr_reader :prose

    def initialize block, prose, duration
      @block, @prose, @duration = block, prose, duration
    end

    def self.call prose=nil, duration: nil, &block
      prose ||= "Action does not time out"
      duration ||= Defaults.duration
      block ||= proc { sleep }

      instance = new block, prose, duration
      instance.()
    end

    def call
      test prose do
        refute_raises ::Timeout::Error do
          ::Timeout.timeout duration, &block
        end
      end
    end

    module Defaults
      def self.duration
        0.001
      end
    end
  end
end
