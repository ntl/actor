module Actor
  module Messaging
    class Writer
      class Substitute
        def initialize
          @registered_addresses = Set.new
          @unregistered_addresses = Set.new
          @writes = []
        end

        def register address
          @registered_addresses << address
        end

        def unregister address
          @unregistered_addresses << address
        end

        def write message, wait: nil
          wait = true if wait.nil?

          record = Record.new message, wait

          @writes << record
        end

        Record = Struct.new :message, :wait

        module Assertions
          def registered? address=nil
            if address.nil?
              @registered_addresses.any?
            else
              @registered_addresses.include? address
            end
          end

          def unregistered? address=nil
            if address.nil?
              @unregistered_addresses.any?
            else
              @unregistered_addresses.include? address
            end
          end

          def written? message=nil, wait: nil
            if message.nil?
              check = proc { true }
            elsif wait.nil?
              check = proc { |record| record.message == message }
            else
              check = proc { |record|
                record.message == message && record.wait == wait
              }
            end

            @writes.any? &check
          end
        end

        singleton_class.send :alias_method, :build, :new # subst-attr compat
      end
    end
  end
end
