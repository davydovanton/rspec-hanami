require 'json'

module RSpec
  module Hanami
    module Matchers
      extend ::RSpec::Matchers::DSL

      # @api public
      # Passes if `json` string in the body matches with hash arg
      #
      #
      # @example Accepts numeric and symbol statuses
      #   response = action.call(params)
      #   expect(response).to include_json(name: 'Anton')
      #   expect(response).to include_json(user: { name: 'Anton })
      #
      matcher :include_json do |json_object|
        attr_reader :actual, :object

        description { "include json #{json_object.to_json}" }

        match do |object|
          @object = object
          @actual = object.last.last
          actual == JSON.generate(json_object)
        end

        failure_message { |actual| "expect #{object} to include #{json_object} json" }
        diffable
      end
    end
  end
end
