module Actor
  class Supervisor
    module Queue
      Value = Messaging::Queue::Null.instance

      module Get
        def self.call
          Queue.const_get(:Value)
        end
      end

      module Put
        def self.call queue=nil
          queue ||= Messaging::Queue::Null.instance

          Queue.module_exec do
            remove_const(:Value)
            const_set(:Value, queue)
          end

          queue
        end
      end
    end
  end
end
