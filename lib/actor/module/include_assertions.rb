module Actor
  module Module
    module IncludeAssertions
      def self.call assertions_module, receiver
        receiver.module_exec do
          unless const_defined? :Assertions, false
            receiver_assertions_module = ::Module.new
            const_set :Assertions, receiver_assertions_module
          end

          receiver_assertions_module ||= const_get :Assertions

          receiver_assertions_module.include assertions_module
        end
      end
    end
  end
end
