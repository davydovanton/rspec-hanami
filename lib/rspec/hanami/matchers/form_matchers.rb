module RSpec
  module Hanami
    module Matchers
      extend ::RSpec::Matchers::DSL

      # @api public
      # Alias for: have_action
      #
      alias_matcher :have_form_action, :have_action

      # @api public
      # Alias for: have_method
      #
      alias_matcher :have_form_method, :have_method

      # @api public
      # Alias for: have_field
      #
      alias_matcher :have_form_field, :have_field

      # @api public
      # Passes if form object has a action
      #
      # @example Accepts numeric and symbol statuses
      #
      #   expect(view.form).to have_action('/users')
      #
      matcher :have_action do |action|
        attr_reader :form, :attributes

        description { "have correct action param" }
        match do |form|
          @form = form
          @attributes = form.instance_variable_get('@attributes')
          @attributes[:action] == action
        end

        failure_message { |actual| "expect #{form.inspect} (#{attributes}) to have #{action} action param" }
        diffable
      end

      # @api public
      # Passes if form object has a method
      #
      # @example Accepts numeric and symbol statuses
      #
      #   expect(view.form).to have_action('/users')
      #
      matcher :have_method do |method|
        attr_reader :form, :attributes

        description { "have correct method param" }
        match do |form|
          @form = form
          @attributes = form.instance_variable_get('@attributes')
          @attributes[:method].downcase.to_sym == method.downcase.to_sym
        end

        failure_message { |actual| "expect #{form.inspect} (#{attributes}) to have #{method} method param" }
        diffable
      end

      # @api public
      # Passes if form object has a field with wanted params
      #
      # @example Accepts numeric and symbol statuses
      #
      #   expect(view.form).to have_field(node: input, type: 'text', id: 'user-first-name')
      #
      matcher :have_field do |params|
        require 'hanami/utils/hash'
        attr_reader :form, :form_data, :params

        description { "have field with params" }
        match do |form|
          @form = form
          @params = ::Hanami::Utils::Hash.new(params).symbolize!
          @form_data = RSpec::Hanami::FormParser.new.call(form.to_s)

          form_data.any? do |input|
            input.merge(params) == params.merge(input)
          end
        end

        failure_message { |actual| "expect #{form.inspect} (#{attributes}) to have #{method} method param" }
        diffable
      end
    end
  end
end
