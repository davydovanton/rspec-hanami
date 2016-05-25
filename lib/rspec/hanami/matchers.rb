require 'rspec/core/warnings'
require 'rspec/expectations'
require 'rspec/hanami/match_status'
require 'rspec/hanami/matchers/have_http_status'
require 'rspec/hanami/matchers/be_status'
require 'rspec/hanami/matchers/redirect_to'

module RSpec
  module Hanami
    module Matchers
      extend ::RSpec::Matchers::DSL
    end
  end
end
