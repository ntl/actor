module Actor
  module Messaging
    module Controls
      module Buffer
        class Incrementing
          attr_accessor :gc_count

          def initialize
            @gc_count = 0
            @mutex = Mutex.new
          end

          def [] position
            @mutex.synchronize do
              position + gc_count
            end
          end

          def shift
            @mutex.synchronize do
              self.gc_count += 1
            end
          end

          module Assertions
            def gc_count? count
              gc_count == count
            end
          end
        end
      end
    end
  end
end
