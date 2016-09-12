module Actor
  module Controls
    module Error
      def self.example
        instance_eval <<~RUBY, '/path/to/some_file.rb', 1
          def method_1; raise ::Actor::Controls::Error::Example; end
          def method_2; method_1; end
          method_2
        RUBY
      rescue Example => error
        return error
      end

      Example = Class.new StandardError
    end
  end
end
