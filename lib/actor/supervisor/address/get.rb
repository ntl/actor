module Actor
  class Supervisor
    module Address
      module Get
        def self.call thread_group=nil
          thread_group ||= Thread.current.group

          Registry[thread_group]
        end
      end
    end
  end
end
