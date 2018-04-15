module TestBench
  class Assert
    module Proc
      module Assertions
        def raises_error? error_type=nil
          rescue_error_type = error_type || StandardError

          self.call

          return false

        rescue rescue_error_type => error
          if error_type.nil? or error.instance_of? rescue_error_type
            return true
          end

          raise error
        end
      end

      ::Proc.send :const_set, :Assertions, Assertions
    end
  end
end
