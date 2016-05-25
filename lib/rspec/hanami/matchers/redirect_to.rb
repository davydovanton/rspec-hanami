module RSpec
  module Hanami
    module Matchers
      extend ::RSpec::Matchers::DSL

      # @api public
      # Passes if `response` has a redirect to special url
      #
      # @example Accepts numeric and symbol statuses
      #   response = action.call(params)
      #   expect(response).to redirect_to('site.com')
      #
      matcher :redirect_to do |url|
        attr_reader :actual, :object, :location

        description { "have redirect to url" }
        match do |object|
          @object = object
          @location = object[1]['Location']
          @actual = object.first
          RSpec::Hanami::MatchStatus.new.call(actual, :redirect) &&
            location == url
        end

        failure_message { |actual| "expect #{object} to redirect #{url}" }
        diffable
      end
    end
  end
end
