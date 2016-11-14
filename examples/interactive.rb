require_relative '../init'

module InteractiveExample
  class Upcase
    include Actor

    handle :convert do |convert|
      string = convert.string

      output = Result.new string.upcase

      writer.write output, convert.reply_address
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

    handle :next_string do
      $stdout.write "Enter a string to convert to upcase: "
      $stdout.flush

      :check_input
    end

    handle :check_input do
      input = $stdin.read_nonblock 1024, exception: false

      if input == :wait_readable
        sleep 0.1
        return :check_input
      end

      input.chomp!

      convert = Upcase::Convert.new input, address

      writer.write convert, upcase_address
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

Actor::Supervisor.start do |supervisor|
  InteractiveExample::Prompt.start

  Signal.trap 'INT' do
    puts "\n\n** Received SIGINT; shutting down supervisor **\n\n"
    Actor::Messaging::Writer.(:shutdown, supervisor.address)
  end
end
