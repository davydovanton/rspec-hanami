require 'spec_helper'
require 'rspec/hanami/matchers'

RSpec.describe "be matchers" do
  include RSpec::Hanami::Matchers

  let(:params) { {} }

  describe '#be_success' do
    context 'for SuccessfulAction' do
      let(:action) { SuccessfulAction.new }

      it "return true" do
        response = action.call(params)
        expect(response).to be_success
      end
    end

    context 'for FailedAction' do
      let(:action) { FailedAction.new }

      it "return false" do
        response = action.call(params)
        expect(response).to_not be_success
      end
    end

    context 'for RedirectedAction' do
      let(:action) { RedirectedAction.new }

      it "return false" do
        response = action.call(params)
        expect(response).to be_success
      end
    end
  end
end
