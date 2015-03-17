require_relative 'lib/ruby_pvwatts/version'

Gem::Specification.new do |s|
  s.name = 'ruby_pvwatts'
  s.version = RubyPvWatts::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['Shad Self']
  s.email = 'shad@greensandstudio.com'
  s.licenses = ['MIT']
  s.homepage = 'http://github.com/discypher/ruby_pvwatts'
  s.summary = 'PVWatts JSON API wrapper'
  s.description = 'API wrapper for version 5 of NREL PVWatts JSON API.'
  s.required_ruby_version = '>= 1.9.3'

  s.required_rubygems_version = '>= 1.3.6'
  s.rubyforge_project = 'ruby_pvwatts'

  s.add_dependency 'httparty', '~> 0.13.3'
  s.add_dependency 'json', '~> 1.8'

  s.add_development_dependency 'guard', '~> 2.12', '>= 2.12.5'
  s.add_development_dependency 'guard-rspec', '~> 4.5', '>= 4.5.0'
  s.add_development_dependency 'rspec', '~> 3.2', '>= 3.2.0'
  s.add_development_dependency 'simplecov', '~> 0.9', '>= 0.9.2'
  s.add_development_dependency 'webmock', '~> 1.20', '>= 1.20.4'

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ['lib']
end
