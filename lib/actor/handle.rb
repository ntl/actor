module Actor
  module Handle
    def handle message
      super

      begin
        case message
        when Messaging::SystemMessage::Pause then
          self.actor_state = State::Paused

        when Messaging::SystemMessage::Resume then
          self.actor_state = State::Running

        when Messaging::SystemMessage::Stop then
          self.actor_state = State::Stopped
          raise StopIteration

        when Messaging::SystemMessage::RecordStatus then
          status = message.status

          Statistics::Copy.(status, actor_statistics)

          status.state = actor_state

          Messaging::Writer.write status, message.reply_address
        end
      end
    end
  end
end
