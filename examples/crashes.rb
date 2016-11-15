require_relative '../init'

class Crashes
  include Actor

  handle :start do
    raise Error
  end

  Error = Class.new StandardError
end

Actor::Supervisor.start do
  Crashes.start
end
