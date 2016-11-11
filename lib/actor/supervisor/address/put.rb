module Actor
  class Supervisor
    module Address
      module Put
        def self.call address
          group = Thread.current.group

          Registry[group] = address
        end
      end
    end
  end
end
