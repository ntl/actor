module Actor
  module Module
    def self.included cls
      cls.class_exec do
        extend Build
        extend HandleMacro
        extend Start
      end
    end

    attr_writer :address
    attr_writer :reader
    attr_writer :writer

    def configure
    end

    def continuations
      @continuations ||= []
    end

    def handle message
      method = handle? message

      return if method.nil?

      if method.arity == 0
        method.()
      else
        method.(message)
      end
    end

    def handle_stop
      raise StopIteration
    end

    def handle? message
      method_name = HandleMacro::MethodName.get message

      if respond_to? method_name
        method method_name
      end
    end

    def next
      if continuations.empty?
        message = reader.(wait: true)
      else
        message = reader.(wait: false)
        message ||= continuations.shift
      end

      continuation_message = handle message

      if handle? continuation_message
        continuations << continuation_message
      end
    end

    def run_loop
      loop do
        self.next
        Thread.pass
      end
    end
    alias_method :start, :run_loop

    def address
      @address ||= Address::None
    end

    def reader
      @reader ||= Messaging::Read::Substitute.new
    end

    def writer
      @writer ||= Messaging::Write::Substitute.new
    end
  end
end
