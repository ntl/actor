module TestBench
  class Registry
    attr_reader :factory

    def initialize factory
      @factory = factory
    end

    def self.build &block
      factory = block
      new factory
    end

    def key binding
      binding.receiver.object_id
    end

    def get binding
      key = self.key binding
      table[key] ||= factory.()
    end

    def set binding, value
      key = self.key binding
      table[key] = value
    end

    def table
      @table ||= {}
    end
  end
end
