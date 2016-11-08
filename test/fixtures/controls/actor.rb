module Fixtures
  module Controls
    module Actor
      class Example
        include ::Actor

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
