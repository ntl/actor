module Actor
  module Module
    module RunLoop
      def run_loop &supplemental_action
        loop do
          message = read.()

          handle message

          supplemental_action.() if supplemental_action
        end
      end

      def handle_stop(_=nil)
        raise StopIteration
      end
    end
  end
end
