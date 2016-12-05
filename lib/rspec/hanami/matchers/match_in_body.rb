module RSpec
  module Hanami
    module Matchers
      extend ::RSpec::Matchers::DSL

      # @api public
      # Passes if `response` has a not 4xx and 5xx error code.
      #
      # @example Accepts numeric and symbol statuses
      #   response = action.call(params)
      #   expect(response).to be_success
      #
      matcher :match_in_body do |regexp|
        attr_reader :actual, :object

        description { "match #{regexp} in body" }
        match do |object|
          @object = object
          @actual = object.last.first
          !!actual.match(Regexp.new(regexp))
        end

        failure_message { |actual| "expect #{object} to have text #{regexp} in body" }
        diffable
      end
    end
  end
end
