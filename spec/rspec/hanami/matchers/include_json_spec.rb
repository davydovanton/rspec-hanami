require 'spec_helper'

RSpec.describe "include_json", type: :request do
  let(:params) { {} }

  context 'for JsonAction' do
    let(:action) { JsonAction.new }

    it "return true" do
      response = action.call(params)
      expect(response).to include_json(user: { name: 'Anton' })
    end

    it "return false" do
      response = action.call(params)
      expect(response).to_not include_json(user: 'Anton')
    end
  end
end
