module Actor
  module Module
    module Build
      def build address, *positional_arguments, **keyword_arguments, &block
        if keyword_arguments.empty?
          instance = new *positional_arguments, &block
        else
          instance = new *positional_arguments, **keyword_arguments, &block
        end

        instance.reader = Messaging::Read.build address
        instance.writer = Messaging::Write.new

        instance.configure

        instance
      end
    end
  end
end
