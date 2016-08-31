module Actor
  module Controls
    module Actor
      def self.example
        Example.new
      end

      class Example
        include ::Actor

        def action
          @acted = true
        end

        def action_executed?
          @acted == true
        end

        def handle message
          handled_messages << message
        end

        def handled_messages
          @handled_messages ||= []
        end

        module Assertions
          def handled_message? expected_message
            expected_message ||= Message.example

            @handled_messages.include? expected_message
          end
        end
      end

      class CrashesImmediately < Example
        def action
          super
          raise Error, "Induced error"
        end

        Error = Class.new StandardError
      end

      class StopsImmediately < Example
        def action
          super
          raise StopIteration
        end
      end

      class ConstructorArguments < StopsImmediately
        attr_reader :req, :opt, :keyreq, :key, :block

        def initialize req, opt=nil, keyreq:, key: nil, &block
          @req, @opt, @keyreq, @key, @block = req, opt, keyreq, key, block
        end
      end

      class FactoryMethod < ConstructorArguments
        def self.build req
          new req, keyreq: 'keyreq-value'
        end

        def argument_passed_in? value
          req == value
        end

        def constructed_by_factory_method?
          keyreq == 'keyreq-value'
        end
      end
    end
  end
end
