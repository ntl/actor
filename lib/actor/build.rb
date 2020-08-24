module Actor
  class Build
    attr_reader :args
    attr_reader :kwargs
    attr_reader :block
    attr_reader :cls

    attr_accessor :queue

    def initialize(cls, args, kwargs, block)
      @cls = cls
      @args = args
      @kwargs = kwargs
      @block = block
    end

    def self.build(cls, *args, queue: nil, **kwargs, &block)
      instance = new(cls, args, kwargs, block)
      instance.queue = queue
      instance
    end

    def self.call(cls, *args, queue: nil, **kwargs, &block)
      instance = build(cls, *args, queue: queue, **kwargs, &block)
      instance.()
    end

    def call
      if cls.respond_to?(:build)
        method = cls.method(:build)
      else
        method = cls.method(:new)
      end

      if block
        actor = method.(*args, **kwargs, &block)
      else
        actor = method.(*args, **kwargs)
      end

      actor.configure(actor_queue: queue)

      actor
    end
  end
end
