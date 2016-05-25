module RSpec
  module Hanami
    class MatchStatus
      def call(actual, expected)
        case expected
        when Numeric
          actual == expected
        when Symbol
          chec_symbol_status(actual, expected)
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

      def chec_symbol_status(actual, expected)
        status = TYPE_CODES[expected]

        if status
          !!actual.to_s.match(status)
        else
          actual == Rack::Utils::SYMBOL_TO_STATUS_CODE[expected]
        end
      end
    end
  end
end
