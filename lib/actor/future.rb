module Actor
  class Future
    attr_reader :reader
    attr_accessor :message

    def initialize reader
      @reader = reader
    end

    def self.build &block
      address = Address.build
      reader = Messaging::Read.build address

      instance = new reader

      block.(address)

      instance
    end

    def self.get wait: nil, &block
      instance = build &block
      instance.get wait: wait
    end

    def get wait: nil
      return message unless message.nil?

      self.message = reader.(wait: wait)
    end

    def ready?
      get

      message ? true : false
    end
  end
end
