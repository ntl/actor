module TestBench
  class Executor
    attr_reader :binding
    attr_reader :kernel

    def initialize binding, kernel
      @binding = binding
      @kernel = kernel
    end

    def self.build
      binding = TOPLEVEL_BINDING

      new binding, Kernel
    end

    def call files
      files.each do |file|
        execute file
      end

      telemetry.passed?
    end

    def execute file
      telemetry.file_started file

      begin
        unbound_context_method = TestBench::Structure.instance_method :context
        bound_context_method = unbound_context_method.bind binding.receiver

        bound_context_method.call :suppress_exit => true do
          kernel.load File.expand_path file
        end

      ensure
        telemetry.file_finished file
      end
    end

    def telemetry
      Telemetry::Registry.get binding
    end
  end
end
