require 'spec_helper'

RSpec.describe 'match_in_body', type: :request do
  let(:params) { {} }

  context 'for SuccessfulAction' do
    let(:action) { SuccessfulAction.new }
    it { expect(action.call(params)).to match_in_body('Hi') }
    it { expect(action.call(params)).to match_in_body('successful') }
  end

  context 'for FailedAction' do
    let(:action) { FailedAction.new }
    it { expect(action.call(params)).to match_in_body('Hi') }
    it { expect(action.call(params)).to match_in_body('failed') }
  end
end
