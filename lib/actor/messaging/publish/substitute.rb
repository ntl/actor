module Actor
  module Messaging
    class Publish
      class Substitute
        attr_reader :records
        attr_reader :registered_queuees
        attr_reader :unregistered_queuees

        def initialize
          @registered_queuees = Set.new
          @unregistered_queuees = Set.new
          @records = []
        end

        def register queue
          registered_queuees << queue
        end

        def unregister queue
          unregistered_queuees << queue
        end

        def call message, wait: nil
          wait = false if wait.nil?

          record = Record.new message, wait

          records << record
        end

        def registered? queue=nil
          if queue.nil?
            registered_queuees.any?
          else
            registered_queuees.include? queue
          end
        end

        def unregistered? queue=nil
          if queue.nil?
            unregistered_queuees.any?
          else
            unregistered_queuees.include? queue
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

        Record = Struct.new :message, :wait

        singleton_class.send :alias_method, :build, :new # subst-attr compat
      end
    end
  end
end
