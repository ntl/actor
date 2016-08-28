module Actor
  def self.included cls
    cls.class_exec do
      extend Destructure
      extend Spawn
      extend Start

      prepend UpdateStatistics
    end
  end

  attr_accessor :actor_address
  attr_accessor :actor_state
  attr_writer :reader

  def action
  end

  def actor_statistics
    @actor_statistics ||= Statistics.new
  end

  def handle _
  end

  def handle_system_message message
    case message
    when SystemMessage::Pause then
      self.actor_state = State::Paused

    when SystemMessage::Resume then
      self.actor_state = State::Running

    when SystemMessage::Stop then
      self.actor_state = State::Running
      raise StopIteration

    when SystemMessage::RecordStatus then
      status = message.status

      Statistics::Copy.(status, actor_statistics)

      status.state = actor_state

      Messaging::Writer.write status, message.reply_address
    end
  end

  def reader
    @reader ||= Reader::Substitute.new
  end

  def run_loop
    loop do
      while message = reader.read(wait: actor_state == State::Paused)
        handle message

        if message.is_a? SystemMessage
          handle_system_message message
        end
      end

      action if actor_state == State::Running

      Thread.pass
    end

    self.actor_state = State::Stopped
  end

  module Destructure
    def destructure actor, address, thread, include: nil
      return address if include.nil?

      result = [address]

      include.each do |variable_name|
        value = binding.local_variable_get variable_name

        result << value
      end

      return *result
    end
  end

  module Spawn
    def spawn *positional_arguments, include: nil, **keyword_arguments, &block
      address = Messaging::Address.get

      method = if respond_to? :build then :build else :new end

      if keyword_arguments.empty?
        instance = __send__ method, *positional_arguments, &block
      else
        instance = __send__ method, *positional_arguments, **keyword_arguments, &block
      end

      reader = Messaging::Reader.build address

      instance.actor_address = address
      instance.actor_state = State::Paused
      instance.reader = reader

      thread = ::Thread.new do
        instance.run_loop
      end

      destructure instance, address, thread, include: include
    end
  end

  module Start
    def start *positional_arguments, include: nil, **keyword_arguments, &block
      address, instance, thread = spawn(
        *positional_arguments,
        include: %i(actor thread),
        **keyword_arguments,
        &block
      )

      Messaging::Writer.write(
        SystemMessage::Resume.new,
        address
      )

      destructure instance, address, thread, include: include
    end
  end

  module State
    Paused = :paused
    Running = :running
    Stopped = :stopped
  end

  module UpdateStatistics
    def action
      actor_statistics.executing_action

      result = super

      actor_statistics.action_executed

      result
    end
  end
end
