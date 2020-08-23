module Fixtures
  class ExecuteWithinThread
    include TestBench::Fixture

    attr_reader :block

    def initialize block
      @block = block
    end

    def self.call &block
      instance = new block
      instance.()
    end

    def call
      if RUBY_ENGINE == 'mruby'
        thread = Thread.new(block) do |blk|
          blk.()
        end

        thread.join
      else
        result = nil

        thread = Thread.new do
          result = block.()
        end

        thread.join

        result
      end
    end
  end
end
