# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = [ENV['GEM_NAME_PREFIX'], 'actor'].compact.join '-'
  s.version = ENV.fetch('GEM_VERSION')

  s.authors = ['Nathan Ladd']
  s.homepage = 'https://github.com/ntl/actor'
  s.email = 'nathanladd+github@gmail.com'
  s.licenses = %w(MIT)
  s.summary = %{Implementation of actor pattern for Ruby}
  s.description = %{Implementation of actor pattern for Ruby}

  s.require_paths = %w(lib src)
  s.files = Dir.glob('lib/**/*')

  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '~> 2.5'
end
