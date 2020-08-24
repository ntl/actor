module Actor
  module Module
    module Start
      def start *args, include: nil, **kwargs, &block
        queue = Messaging::Queue.get

        thread = Actor::Start.(self, queue, *args, queue: queue, **kwargs, &block)

        if include
          return_values = [queue]

          values = { :thread => thread }

          Array(include).each do |label|
            argument = values.fetch(label)

            return_values << argument
          end

          return return_values
        else
          return queue
        end
      end
    end
  end
end
