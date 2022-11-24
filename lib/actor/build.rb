module Actor
  class Build
    attr_reader :arguments
    attr_reader :keyword_arguments
    attr_reader :block
    attr_reader :cls

    def initialize cls, arguments, keyword_arguments, &block
      @arguments = arguments
      @keyword_arguments = keyword_arguments
      @block = block
      @cls = cls
    end

    def self.call cls, *arguments, **keyword_arguments, &block
      instance = new cls, arguments, keyword_arguments, &block
      instance.()
    end

    def call
      if cls.respond_to? :build
        method = cls.method :build
      else
        method = cls.method :new
      end

      if block
        actor = method.(*arguments, **keyword_arguments, &block)
      else
        actor = method.(*arguments, **keyword_arguments)
      end

      actor.configure

      actor
    end
  end
end
