module Actor
  module Messaging
    class Publish
      class Substitute
        attr_reader :records
        attr_reader :registered_addresses
        attr_reader :unregistered_addresses

        def initialize
          @registered_addresses = Set.new
          @unregistered_addresses = Set.new
          @records = []
        end

        def register address
          registered_addresses << address
        end

        def unregister address
          unregistered_addresses << address
        end

        def call message, wait: nil
          wait = true if wait.nil?

          record = Record.new message, wait

          records << record
        end

        Record = Struct.new :message, :wait

        module Assertions
          def registered? address=nil
            if address.nil?
              registered_addresses.any?
            else
              registered_addresses.include? address
            end
          end

          def unregistered? address=nil
            if address.nil?
              unregistered_addresses.any?
            else
              unregistered_addresses.include? address
            end
          end

          def published? message=nil, wait: nil
            records.each do |record|
              next unless message.nil? or record.message == message
              next unless wait.nil? or record.wait == wait

              return true
            end

            false
          end
        end

        singleton_class.send :alias_method, :build, :new # subst-attr compat
      end
    end
  end
end
