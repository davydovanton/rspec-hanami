require 'hanami/utils/hash'

module RSpec
  module Hanami
    class FormParser
      def call(html)
        meta_list = select_inputs(html).map! { |input| input_data_hash(input) }
        meta_list.map! { |hash| ::Hanami::Utils::Hash.new(hash).symbolize! }
      end

    private

      def select_inputs(html)
        html.scan(/<input.+>|<textarea[^<]+>/)
      end

      def input_data_hash(input)
        # trim all '<' and '>' chars. After that I add data
        # attr 'node' for first element (html tag name). And
        # in the end I split string on key-value pairs, trim '"'
        # and split key-value to key and value array.
        Hash[
          input
            .tr('<', '')
            .tr('>', '')
            .prepend('node=')
            .split(' ')
            .map! { |key_value| key_value.tr('"', '').split('=') }
        ]
      end
    end
  end
end
