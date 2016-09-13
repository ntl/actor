module Actor
  module Controls
    module Actor
      def self.example
        Example.new
      end

      class Example
        include ::Actor

        def initialize
          @messages = []
        end

        handle Message::Example do |message|
          @messages << message
        end

        def handled? message
          @messages.include? message
        end
      end

      class Singleton
        include ::Actor

        def self.define &block
          cls = Class.new Singleton
          cls.class_exec &block if block
          cls.new
        end
      end
    end
  end
end
