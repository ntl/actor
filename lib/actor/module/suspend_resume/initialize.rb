module Actor
  module Module
    module SuspendResume
      module Initialize
        def initialize *;
          @suspended = false

          super
        end
      end
    end
  end
end
