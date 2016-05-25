require 'rspec/core/warnings'
require 'rspec/expectations'
require 'rspec/hanami/matchers/have_http_status'

module RSpec
  module Hanami
    module Matchers
      extend ::RSpec::Matchers::DSL
    end
  end
end
