module TestBench
  module Fixture
    def self.included cls
      cls.class_exec do
        extend Forwardable

        delegate %i(assert comment context refute test) => :structure
      end
    end

    attr_writer :structure

    def structure
      @structure ||= TOPLEVEL_BINDING.receiver
    end
  end
end
