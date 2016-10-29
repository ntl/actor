#!/usr/bin/env ruby --disable-gems

ENV['TEST_BENCH_TESTS_DIR'] ||= 'test/scripts'

require_relative './test_init'

require 'test_bench/cli'

TestBench::CLI.() or exit 1
