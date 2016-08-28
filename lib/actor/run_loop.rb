module Actor
  module RunLoop
    def run_loop
      loop do
        begin
          message = reader.read wait: actor_state == State::Paused

          handle message if message
        end until message.nil?

        action if actor_state == State::Running

        Thread.pass
      end
    end
  end
end
