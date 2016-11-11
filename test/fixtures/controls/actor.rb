module Fixtures
  module Controls
    module Actor
      def self.example address=nil
        actor = Example.new
        actor.address = address if address
        actor
      end

      def self.define &block
        Class.new do
          include ::Actor
          include ::Actor::Controls
          include ::Actor::Module::SuspendResume::Controls

          class_exec &block if block
        end
      end

      def self.define_singleton *arguments, &block
        cls = define &block

        actor = cls.new *arguments

        actor
      end

      Example = define do
        def initialize
          @handled_messages = []
        end

        handle :some_message do |msg|
          @handled_messages << msg
          msg
        end
      end

      class Example
        module Assertions
          def handled? msg
            @handled_messages.include? msg
          end
        end
      end
    end
  end
end
