# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = [ENV['GEM_NAME_PREFIX'], 'actor'].compact.join '-'
  s.version = ENV.fetch 'GEM_VERSION'

  s.authors = ['Nathan Ladd']
  s.homepage = 'https://github.com/ntl/actor'
  s.email = 'nathanladd+github@gmail.com'
  s.licenses = %w(MIT)
  s.summary = "Implementation of actor pattern for ruby"
  s.description = "Implementation of actor pattern for ruby designed for simplicity and frugality"

  s.require_paths = %w(lib)
  s.files = Dir.glob 'lib/**/*'
  s.platform = Gem::Platform::RUBY
end
