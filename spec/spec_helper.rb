require 'simplecov'
SimpleCov.start

require 'ruby_pvwatts'
require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)
