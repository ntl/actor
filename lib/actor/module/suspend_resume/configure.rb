module Actor
  module Module
    module SuspendResume
      module Configure
        def configure(actor_queue: nil)
          self.suspend_queue = Messaging::Queue.get

          super
        end
      end
    end
  end
end
