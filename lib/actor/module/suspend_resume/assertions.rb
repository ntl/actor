module Actor
  module Module
    module SuspendResume
      module Assertions
        def self.included mod
          mod.module_exec do
            extend Extended
          end
        end

        def message_deferred? message, wait: nil
          suspend_queue.enqueued? message, wait: wait
        end

        def suspended?
          @suspended == true
        end

        module Extended
          def extended actor
            actor.instance_exec do
              assertions_module = suspend_queue.class::Assertions

              suspend_queue.extend assertions_module
            end
          end
        end
      end
    end
  end
end
