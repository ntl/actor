module Actor
  module Module
    module SuspendResume
      module Configure
        def configure
          self.suspend_queue = Messaging::Queue.get

          super
        end
      end
    end
  end
end
