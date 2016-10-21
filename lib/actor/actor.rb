module Actor
  # It is possible to `include Actor' in the top-level namespace in order to
  # bring this library's constants into focus (i.e. reference them without any
  # leading `Actor' reference to qualify them). The test suite does this; see
  # tests/test_init.rb. In that case, we take care not to attach any Actor
  # behavior onto Object. This is achieved by placing the implementation of
  # Actor in Actor::Module
  def self.included cls
    cls.include Module unless cls == Object
  end

  module Module
    def self.included cls
      cls.class_exec do
        extend HandleMacro
        extend Start

        include Observers

        prepend Configure
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
        return_value = method.()
      else
        return_value = method.(message)
      end

      notify_observers message

      return_value
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

    module Configure
      def configure
        super

        self.reader = Messaging::Read.build address
        self.writer = Messaging::Write.new
      end
    end

    module Start
      def start *positional_arguments, address: nil, supervisor_address: nil, include: nil, **keyword_arguments, &block
        address ||= Address.build

        if respond_to? :build
          constructor = method :build
        else
          constructor = method :new
        end

        if keyword_arguments.empty?
          instance = constructor.(*positional_arguments, &block)
        else
          instance = constructor.(*positional_arguments, **keyword_arguments, &block)
        end

        instance.address = address

        instance.configure

        thread = Actor::Start.(
          instance,
          address,
          supervisor_address: supervisor_address
        )

        Destructure.(address, include, { :thread => thread, :actor => instance })
      end
    end
  end
end
