module RSpec
  module Hanami
    module Matchers
      extend ::RSpec::Matchers::DSL

      # @api public
      # Passes if `parameter` has an passed attribute of expected type
      # Hanami::Entity::Types are allowed
      #
      # expect(User).to have_attribute(:name, Type::String)
      #
      matcher :have_attribute do |parameter, type|
        attr_reader :expected_type

        description { "have #{expected_type.name} type" }
        match do |object|
          @attributes = object.instance_variable_get(:@attributes)
          @actual = @attributes[parameter]
          @expected_type = type

          RSpec::Hanami::MatchType.new(actual, expected_type).call
        end

        failure_message do |actual|
          "expected that #{actual.class} should match with #{expected_type.name}"\
          "\nDiff: #{differ.diff_as_string(actual.class.to_s, expected_type.name)}"
        end

        failure_message_when_negated do |actual|
          "expected that #{actual.class} should not match with #{expected_type.name}"
        end

        def differ
          RSpec::Support::Differ.new(
            color: RSpec::Matchers.configuration.color?
          )
        end
      end

      # @api public
      # Passes if all `parameters` has an passed attribute of expected types.
      # Hanami::Entity::Types are allowed
      #
      # expect(User).to have_attributes(name: Type::String, ...)
      #
      matcher :have_attributes do |**parameters|
        attr_reader :attributes, :actual_types, :expected_types

        description { "have #{expected_types} types" }
        match do |object|
          @attributes = object.instance_variable_get(:@attributes)
          @actual_types = attributes.map { |_attr, type| type.class }.join(', ')
          @expected_types = parameters.map { |_attr, type| type.name }.join(', ')

          parameters.all? do |attribute, type|
            actual = attributes[attribute]
            RSpec::Hanami::MatchType.new(actual, type).call
          end
        end

        failure_message do |_actual|
          "expected that #{actual_types} should match with #{expected_types}"\
          "\nDiff: #{differ.diff_as_string(actual_types, expected_types)}"
        end

        failure_message_when_negated do |_actual|
          "expected that #{actual_types} should not match with #{expected_types}"
        end

        def differ
          RSpec::Support::Differ.new(
            color: RSpec::Matchers.configuration.color?
          )
        end
      end
    end
  end
end
