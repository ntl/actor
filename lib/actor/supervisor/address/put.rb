module Actor
  class Supervisor
    module Address
      module Put
        def self.call address
          thread_group = Thread.current.group

          Registry[thread_group] = address
        end
      end
    end
  end
end
