module Actor
  class Supervisor
    module Address
      Value = Messaging::Address::None.instance

      module Get
        def self.call
          Address.const_get(:Value)
        end
      end

      module Put
        def self.call address=nil
          address ||= Messaging::Address::None.instance

          Address.module_exec do
            remove_const(:Value)
            const_set(:Value, address)
          end

          address
        end
      end
    end
  end
end
