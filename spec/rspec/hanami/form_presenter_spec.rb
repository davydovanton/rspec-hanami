require 'spec_helper'
require 'rspec/hanami/matchers'

RSpec.describe RSpec::Hanami::FormPresenter do
  let(:form_html_string) {
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
  }
  let(:form_data)       { RSpec::Hanami::FormParser.new.(form_html_string) }
  let(:form_presenter)  { RSpec::Hanami::FormPresenter.new }
  let(:expectation)     {
    <<~EXP.chomp
      {:node=>"form", :action=>"/users", :method=>"POST", :"accept-charset"=>"utf-8", :id=>"user-form"}
        {:node=>"label", :for=>"password-reset-email"}
        {:node=>"input", :type=>"text", :id=>"user-first-name", :name=>"user[first_name]", :value=>"L"}
        {:node=>"input", :type=>"hidden", :name=>"user[free_shipping]", :value=>"0"}
        {:node=>"input", :type=>"checkbox", :name=>"user[free_shipping]", :id=>"user-free-shipping", :value=>"1"}
        {:node=>"textarea", :name=>"user[description]", :id=>"desc"}
        {:node=>"datalist", :id=>"places"}
          {:node=>"option", :value=>"Moscow"}
          {:node=>"option", :value=>"Rome"}
        {:node=>"select", :name=>"password_reset[places]", :id=>"password-reset-places"}
          {:node=>"option", :value=>"it"}
          {:node=>"option", :value=>"us"}
        {:node=>"button", :type=>"submit"}
    EXP
   }

  describe '#call' do
    it 'presents form_data in a nice way' do
      result = form_presenter.(form_data)

      expect(result).to eq expectation
    end
  end
end
