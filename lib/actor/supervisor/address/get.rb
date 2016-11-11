module Actor
  class Supervisor
    module Address
      module Get
        def self.call thread_group=nil
          thread_group ||= Thread.current.group

          Registry.fetch thread_group do
            Messaging::Address::None.instance
          end
        end
      end
    end
  end
end
