require 'pp'

require_relative '../init'

require 'test_bench/activate'

require 'actor/messaging/controls'

require_relative './fixtures/fixtures_init'

include Actor::Messaging

Thread.abort_on_exception = true
