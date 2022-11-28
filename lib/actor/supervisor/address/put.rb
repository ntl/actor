module Actor
  class Supervisor
    module Address
      module Put
        def self.call(address=nil)
          thread_group = Thread.current.group

          if address.nil?
            Registry.delete(thread_group)
          else
            Registry[thread_group] = address
          end
        end
      end
    end
  end
end
