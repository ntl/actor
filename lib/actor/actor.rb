module Actor
  # It is possible to `include Actor' in the top-level namespace in order to
  # bring this library's constants into focus (i.e. reference them without any
  # leading `Actor' reference to qualify them). The test suite does this; see
  # tests/test_init.rb. In that case, we take care not to attach any Actor
  # behavior onto Object.
  def self.included cls
    cls.include Mixin unless cls == Object
  end

  module Mixin
    def self.included cls
      cls.class_exec do
        extend HandleMacro
        prepend StopHandler
      end
    end

    attr_writer :reader
    attr_writer :writer

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

      if continuation_message.is_a? Messaging::Message
        continuations << continuation_message
      end
    end

    def run_loop
      loop do self.next end
    end
    alias_method :start, :run_loop

    def reader
      @reader ||= Messaging::Read::Substitute.new
    end

    def writer
      @writer ||= Messaging::Write::Substitute.new
    end

    module StopHandler
      def handle message, *;
        return_value = super

        raise StopIteration if message.instance_of? Messages::Stop

        return_value
      end
    end
  end
end
