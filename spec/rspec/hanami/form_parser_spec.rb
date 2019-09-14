require 'spec_helper'
require 'rspec/hanami/matchers'

RSpec.describe RSpec::Hanami::FormParser do
  let(:parser) { RSpec::Hanami::FormParser.new }
  let(:form_html_string) do
    <<~FORM
      <form action="/users" method="POST" accept-charset="utf-8" id="user-form">
        <label for="password-reset-email">Email</label>
        <input type="text" id="user-first-name" name="user[first_name]" value="L">
        <input type="hidden" name="user[free_shipping]" value="0">
        <input type="checkbox" name="user[free_shipping]" id="user-free-shipping" value="1">
        <textarea name="user[description]" id="desc"></textarea>
        <datalist id="places">
          <option value="Moscow"></option>
          <option value="Rome"></option>
        </datalist>
        <select name="password_reset[places]" id="password-reset-places">
          <option value="it">Italy</option>
          <option value="us">United States</option>
        </select>
        <button type="submit">Create</button>
      </form>
    FORM
  end

  describe '#call' do
    it 'parses form html string to inputs hash list' do
      result = parser.(form_html_string)
      expect(result.count).to eq 13
      expect(result[2]).to eq(node: "input", type: "text", id: "user-first-name", name: "user[first_name]", value: "L")
      expect(result.map{ |i| i[:node] }).to eq(%w[form label input input input textarea datalist option option select option option button])
      expect(result.map{ |i| i[:type] }).to eq([nil, nil, 'text', 'hidden', 'checkbox', nil, nil, nil, nil, nil, nil, nil, "submit"])
    end
  end
end
