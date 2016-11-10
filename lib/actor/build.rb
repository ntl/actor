module Actor
  class Build
    attr_reader :arguments
    attr_reader :block
    attr_reader :cls

    def initialize cls, arguments, &block
      @arguments = arguments
      @block = block
      @cls = cls
    end

    def self.call cls, *arguments, &block
      instance = new cls, arguments, &block
      instance.()
    end

    def call
      if cls.respond_to? :build
        method = cls.method :build
      else
        method = cls.method :new
      end

      if block
        method.(*arguments, &block)
      else
        method.(*arguments)
      end
    end
  end
end
