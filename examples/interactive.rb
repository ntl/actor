require_relative '../init'

module InteractiveExample
  class Upcase
    include Actor

    handle :convert do |convert|
      string = convert.string

      output = Result.new string.upcase

      writer.(output, convert.reply_address)
    end

    handle :stop do
      super()
    end

    Convert = Struct.new :string, :reply_address do
      include Actor::Messaging::Message
    end

    Result = Struct.new :string do
      include Actor::Messaging::Message
    end
  end

  class Prompt
    include Actor

    handle :start do
      $stdout.sync = true

      :next_string
    end

    handle :stop do
      super()
    end

    handle :next_string do
      $stdout.write "Enter a string: "
      $stdout.flush

      :check_input
    end

    handle :check_input do
      input = $stdin.read_nonblock 1024, exception: false

      return :check_input if input == :wait_readable

      convert = Upcase::Convert.new input, address

      writer.(convert, upcase_address)
    end

    handle :result do |result|
      $stdout.write "Uppercase: #{result.string}\n"

      :next_string
    end

    def configure
      @upcase_address = Upcase.start
    end

    def upcase_address
      @upcase_address ||= Actor::Address::None
    end
  end
end

Actor::Supervisor.run do |supervisor|
  InteractiveExample::Prompt.start

  Signal.trap 'INT' do
    puts "\n\n** Received SIGINT; shutting down supervisor **\n\n"
    Actor::Messaging::Write.(:shutdown, supervisor.address)
  end
end
