require 'rspec/core/warnings'
require 'rspec/expectations'
require 'rspec/hanami/form_parser'
require 'rspec/hanami/form_presenter'
require 'rspec/hanami/match_status'
require 'rspec/hanami/match_type'
require 'rspec/hanami/matchers/have_http_status'
require 'rspec/hanami/matchers/match_in_body'
require 'rspec/hanami/matchers/be_status'
require 'rspec/hanami/matchers/form_matchers'
require 'rspec/hanami/matchers/redirect_to'
require 'rspec/hanami/matchers/match_entity_schema'
require 'rspec/hanami/matchers/include_json'

module RSpec
  module Hanami
    module Matchers
      extend ::RSpec::Matchers::DSL
    end
  end
end
