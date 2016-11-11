module Actor
  class Supervisor
    module Address
      module Get
        def self.call
          group = Thread.current.group

          Registry[group]
        end
      end
    end
  end
end
