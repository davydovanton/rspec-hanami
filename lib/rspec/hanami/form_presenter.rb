require 'hanami/utils/hash'

module RSpec
  module Hanami
    class FormPresenter
      def call(form_data)
        stringify = form_data.map(&:to_h).map(&:to_s)
        indentify = stringify.map.with_index do |value, index|
          value = "  " + value if index > 0
          value = "  " + value if value.match(/option/)
          value
        end
        indentify.join("\n")
      end
    end
  end
end
