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
      Continue.new
    end

    handle :add_route do |message|
      reader = message.reader
      output_address = message.output_address

      add reader, output_address
    end

    handle :continue do |message|
      routed_messages = false

      routes.each do |input_reader, outputs|
        msg = input_reader.(wait: false)

        next unless msg

        routed_messages = true

        outputs.each do |output|
          writer.(msg, output)
        end
      end

      unless routed_messages
        kernel.sleep Duration.millisecond
      end

      message
    end

    handle :remove_route do |message|
      reader = message.reader
      output_address = message.output_address

      remove reader, output_address
    end

    def add reader, output_address
      routes[reader] << output_address
    end

    def remove reader, output_address
      routes[reader].delete output_address
    end

    def configure
      self.kernel = Kernel
    end

    def kernel
      @kernel ||= Substitutes::Kernel.new
    end

    AddRoute = Struct.new :reader, :output_address
    Continue = Class.new
    RemoveRoute = Struct.new :reader, :output_address

    module Assertions
      def route? reader, output_address
        routes[reader].include? output_address
      end
    end
  end
end
