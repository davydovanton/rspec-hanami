module RSpec
  module Hanami
    module Matchers
      extend ::RSpec::Matchers::DSL

      # @api public
      # Passes if `response` has a matching HTTP status code.
      #
      # The following symbolic status codes are allowed:
      # - `:error`
      # - `:missing`
      # - `:redirect`
      # - `:success`
      #
      # @example Accepts numeric and symbol statuses
      #   response = action.call(params)
      #   expect(response).to have_http_status(404)
      #   expect(response).to have_http_status(:created)
      #   expect(response).to have_http_status(:success)
      #   expect(response).to have_http_status(:error)
      #   expect(response).to have_http_status(:missing)
      #   expect(response).to have_http_status(:redirect)
      #
      matcher :have_http_status do |status|
        attr_reader :actual, :object

        description { "have response #{status}" }
        match do |object|
          @object = object
          @actual = object.first
          RSpec::Hanami::MatchStatus.new.call(actual, status)
        end

        failure_message { |actual| "expect #{object} to have status #{status}" }
        diffable
      end
    end
  end
end
