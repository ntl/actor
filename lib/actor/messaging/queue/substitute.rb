module Actor
  module Messaging
    module Queue
      class Substitute
        def initialize
          @records = ::Queue.new
        end

        def self.build
          instance = new
          instance.extend Controls
          instance
        end

        def deq non_block=nil
          non_block ||= false

          begin
            record = @records.deq true
          rescue ThreadError
          end

          return record.message if record

          if non_block
            nil
          else
            raise WouldBlockError
          end
        end

        def empty?
          @records.empty?
        end

        def enq message, non_block=nil
          non_block ||= false

          record = Record.new message, non_block

          @records.enq record

          record
        end

        Record = Struct.new :message, :non_block

        WouldBlockError = Class.new StandardError

        module Controls
          def add message
            enq message
          end
        end

        module Assertions
          def enqueued? message=nil, wait: nil
            until @records.empty?
              record = @records.deq

              next unless message.nil? or record.message == message
              next unless wait.nil? or record.non_block == !wait

              return true
            end

            false
          end
        end
      end
    end
  end
end
