module TestBench
  class Assert
    attr_reader :block
    attr_reader :mod
    attr_reader :subject

    def initialize subject, mod, block
      @subject = subject
      @mod = mod
      @block = block
    end

    def self.call subject, mod=nil, &block
      block ||= identity_block

      instance = new subject, mod, block
      instance.call
    end

    def assertions_module
      return mod if mod

      if subject_namespace.const_defined? :Assertions
        subject_namespace.const_get :Assertions
      end
    end

    def call
      extend_subject assertions_module if assertions_module

      result = subject.instance_exec subject, &block

      interpret_result result
    end

    def extend_subject mod
      raise TypeError if subject.frozen?
      subject.extend mod
    rescue TypeError
    end

    def interpret_result result
      if result then true else false end
    end

    def subject_namespace
      if subject.is_a? Module
        subject
      else
        subject.class
      end
    end

    def self.identity_block
      @identity_block ||= -> subject do subject end
    end
  end
end
