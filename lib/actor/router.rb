module Actor
  class Router
    include Actor

    attr_writer :kernel
    attr_reader :routes

    def initialize
      @routes = Hash.new do |hash, input|
        hash[input] = Set.new
      end
    end

    handle :start do
      :continue
    end

    handle :continue do
      routed_messages = route_messages

      unless routed_messages
        kernel.sleep Duration.millisecond
      end

      :continue
    end

    handle :add_route do |message|
      reader = message.reader
      output_address = message.output_address

      add reader, output_address
    end

    handle :remove_route do |message|
      reader = message.reader
      output_address = message.output_address

      remove reader, output_address
    end

    handle :stop do
      if routes.any? { |reader, _| reader.messages_available? }
        route_messages
        :stop
      else
        super()
      end
    end

    def add reader, output_address
      routes[reader] << output_address
    end

    def remove reader, output_address
      routes[reader].delete output_address
    end

    def route_messages
      routed_messages = false

      routes.each do |input_reader, outputs|
        msg = input_reader.(wait: false)

        next unless msg

        routed_messages = true

        outputs.each do |output|
          writer.(msg, output)
        end
      end

      routed_messages
    end

    def configure
      self.kernel = Kernel
    end

    def kernel
      @kernel ||= Substitutes::Kernel.new
    end

    AddRoute = Struct.new :reader, :output_address
    RemoveRoute = Struct.new :reader, :output_address

    module Assertions
      def route? reader, output_address
        routes[reader].include? output_address
      end
    end
  end
end
