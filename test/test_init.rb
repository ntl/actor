require 'pp'

require_relative '../init'

require 'test_bench/activate'

require_relative './fixtures/fixtures_init'
require_relative './controls/controls_init'

include Actor

Thread.abort_on_exception = true
