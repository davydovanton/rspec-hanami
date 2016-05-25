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
      matcher :be_success do
        attr_reader :actual, :object

        description { "have response success" }
        match do |object|
          @object = object
          @actual = object.first
          !RSpec::Hanami::MatchStatus.new.call(actual, :error)
        end

        failure_message { |actual| "expect #{object} to have status success" }
        diffable
      end
    end
  end
end
