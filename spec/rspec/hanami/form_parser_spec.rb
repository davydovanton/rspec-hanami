require 'spec_helper'
require 'rspec/hanami/matchers'

RSpec.describe RSpec::Hanami::FormParser do
  let(:parser) { RSpec::Hanami::FormParser.new }
  let(:form_html_string) do
    "<form action=\"/users\" method=\"POST\" accept-charset=\"utf-8\" id=\"user-form\">
      <input type=\"text\" id=\"user-first-name\" name=\"user[first_name]\" value=\"L\">
      <input type=\"hidden\" name=\"user[free_shipping]\" value=\"0\">
      <input type=\"checkbox\" name=\"user[free_shipping]\" id=\"user-free-shipping\" value=\"1\">
      <textarea name=\"user[description]\" id=\"desc\"></textarea>
      <button type=\"submit\">Create</button>
    </form>"
  end

  describe '#call' do
    it 'parses form html string to inputs hash list' do
      result = parser.(form_html_string)
      expect(result.count).to eq 4
      expect(result.first).to eq(node: "input", type: "text", id: "user-first-name", name: "user[first_name]", value: "L")
      expect(result.map{ |i| i[:node] }).to eq(%w[input input input textarea])
      expect(result.map{ |i| i[:type] }).to eq(['text', 'hidden', 'checkbox', nil])
    end
  end
end
