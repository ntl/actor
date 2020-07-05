#!/usr/bin/env ruby --disable-gems

require_relative './test_init'

require 'test_bench/cli'

TestBench::CLI.('test/automated') or exit 1
