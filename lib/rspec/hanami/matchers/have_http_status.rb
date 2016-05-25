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
      #   responce = action.call(params)
      #   expect(responce).to have_http_status(404)
      #   expect(responce).to have_http_status(:created)
      #   expect(responce).to have_http_status(:success)
      #   expect(responce).to have_http_status(:error)
      #   expect(responce).to have_http_status(:missing)
      #   expect(responce).to have_http_status(:redirect)
      #
      matcher :have_http_status do |status|
        attr_reader :actual
        attr_reader :object

        description { "have responce #{status}" }
        match do |object|
          @object = object
          @actual = object.first
          MatchStatus.new.call(actual, status)
        end

        failure_message { |actual| "expect #{object} to have status #{status}" }
        diffable
      end

      class MatchStatus

        def call(actual, expected)
          case expected
          when Numeric
            actual == expected
          when Symbol
            !!actual.to_s.match(TYPE_CODES[expected])
          else
            false
          end
        end

      private

        TYPE_CODES = {
          error: /(4|5)../,
          success: /2../,
          missing: /404/,
          redirect: /3../,
        }.freeze
      end
    end
  end
end
