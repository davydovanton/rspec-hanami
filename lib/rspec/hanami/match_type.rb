module RSpec
  module Hanami
    class MatchType
      attr_reader :actual, :expected

      def initialize(actual, expected)
        @actual = actual
        @expected = expected
      end

      def call
        match_types?
      end

      private

      def match_types?
        return match_if_sum? if expected.class == Dry::Types::Sum

        actual.is_a?(expected.primitive)
      end

      def match_if_sum?
        expected.primitive?(actual)
      end
    end
  end
end
