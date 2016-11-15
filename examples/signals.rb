require_relative '../init'

unless ARGV.empty?
  sig = ARGV[0]

  pid = File.read 'tmp/signals.pid'
  pid = pid.to_i

  Process.kill sig, pid
  exit 
end

pid = Process.pid

File.write 'tmp/signals.pid', pid.to_s

at_exit {
  File.unlink 'tmp/signals.pid' if File.exist? 'tmp/signals.pid'
}

class PrintPeriodically
  include Actor

  attr_writer :counter

  handle :start do
    :print
  end

  handle :print do
    puts "Counter: #{counter}"

    :increment_counter
  end

  handle :increment_counter do
    self.counter += 1

    :sleep
  end

  handle :sleep do
    sleep 0.3

    :start
  end

  def counter
    @counter ||= 0
  end
end

Actor::Supervisor.start do |supervisor|
  Signal.trap 'INT' do
    puts "INT trapped; suspending"
    Actor::Messaging::Write.(:shutdown, supervisor.address)
  end

  Signal.trap 'TSTP' do
    puts "TSTP trapped; suspending"
    Actor::Messaging::Write.(:suspend, supervisor.address)
  end

  Signal.trap 'CONT' do
    puts "CONT trapped; resuming"
    Actor::Messaging::Write.(:resume, supervisor.address)
  end

  PrintPeriodically.start
end
