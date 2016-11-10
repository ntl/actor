module Fixtures
  module Controls
    module Actor
      def self.define &block
        Class.new do
          include ::Actor
          include ::Actor::Controls

          class_exec &block if block
        end
      end

      def self.define_singleton *arguments, &block
        cls = define &block

        actor = cls.new *arguments

        actor
      end

      class Example
        include ::Actor
        include ::Actor::Controls

        def initialize
          @handled_messages = []
        end

        handle :some_message do |msg|
          @handled_messages << msg
          msg
        end

        module Assertions
          def handled? msg
            @handled_messages.include? msg
          end
        end
      end
    end
  end
end
