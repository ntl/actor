module Actor
  module Messaging
    class Reader
      class Substitute
        attr_accessor :message

        def read wait: nil
          wait = true if wait.nil?

          if message.nil? and wait
            raise WouldBlockError
          end

          message
        end

        WouldBlockError = Class.new StandardError

        singleton_class.send :alias_method, :build, :new # subst-attr compat
      end
    end
  end
end
