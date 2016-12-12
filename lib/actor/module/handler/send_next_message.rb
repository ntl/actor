module Actor
  module Module
    module Handler
      module SendNextMessage
        def handle message
          return_value = super

          if Messaging::Message === return_value
            send.(return_value, address)
          end

          return_value
        end
      end
    end
  end
end
