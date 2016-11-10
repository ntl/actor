module Fixtures
  module Controls
    module Error
      def self.example
        error = SomeError.new
        error.set_backtrace backtrace
        error
      end

      def self.backtrace
        ruby = <<~RUBY
        def example_method_1; raise #{SomeError.name}; end
        def example_method_2; example_method_1; end
        def example_method_3; example_method_2; end
        example_method_3
        RUBY

        TOPLEVEL_BINDING.eval ruby, 'some_file.rb', 0

      rescue => error

        lines = ruby.each_line.count
        backtrace = error.backtrace.first lines
        return backtrace
      end

      SomeError = Class.new StandardError
    end
  end
end
