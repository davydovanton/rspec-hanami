require 'rspec/hanami/version'
require 'rspec/hanami/request_helpers'
require 'rspec/hanami/matchers'

RSpec.configure do |config|
  config.include RSpec::Hanami::Matchers, type: :request
  config.include RSpec::Hanami::RequestHelpers, type: :request
end
