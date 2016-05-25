require 'spec_helper'
require 'rspec/hanami/matchers'

RSpec.describe "have_http_status" do
  include RSpec::Hanami::Matchers

  let(:params) { {} }

  describe 'with a successful number status' do
    context 'for SuccessfulAction' do
      let(:action) { SuccessfulAction.new }

      it "return true" do
        response = action.call(params)
        expect(response).to have_http_status(200)
      end
    end

    context 'for FailedAction' do
      let(:action) { FailedAction.new }

      it "return false" do
        response = action.call(params)
        expect(response).to_not have_http_status(200)
      end
    end

    context 'for RedirectedAction' do
      let(:action) { RedirectedAction.new }

      it "return false" do
        response = action.call(params)
        expect(response).to_not have_http_status(200)
      end
    end
  end

  describe 'with a successful symbol status' do
    context 'for SuccessfulAction' do
      let(:action) { SuccessfulAction.new }

      it "return true" do
        response = action.call(params)
        expect(response).to have_http_status(:success)
      end
    end

    context 'for FailedAction' do
      let(:action) { FailedAction.new }

      it 'return true' do
        response = action.call(params)
        expect(response).to_not have_http_status(:success)
      end
    end

    context 'for RedirectedAction' do
      let(:action) { RedirectedAction.new }

      it "return false" do
        response = action.call(params)
        expect(response).to_not have_http_status(:success)
      end
    end
  end

  describe 'with a redirected number status' do
    context 'for SuccessfulAction' do
      let(:action) { SuccessfulAction.new }

      it "return true" do
        response = action.call(params)
        expect(response).to_not have_http_status(302)
      end
    end

    context 'for FailedAction' do
      let(:action) { FailedAction.new }

      it "return false" do
        response = action.call(params)
        expect(response).to_not have_http_status(302)
      end
    end

    context 'for RedirectedAction' do
      let(:action) { RedirectedAction.new }

      it "return false" do
        response = action.call(params)
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'with a redirected symbol status' do
    context 'for SuccessfulAction' do
      let(:action) { SuccessfulAction.new }

      it "return true" do
        response = action.call(params)
        expect(response).to_not have_http_status(:redirect)
      end
    end

    context 'for FailedAction' do
      let(:action) { FailedAction.new }

      it 'return true' do
        response = action.call(params)
        expect(response).to_not have_http_status(:redirect)
      end
    end

    context 'for RedirectedAction' do
      let(:action) { RedirectedAction.new }

      it "return false" do
        response = action.call(params)
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe 'with a error number status' do
    context 'for SuccessfulAction' do
      let(:action) { SuccessfulAction.new }

      it "return true" do
        response = action.call(params)
        expect(response).to_not have_http_status(404)
      end
    end

    context 'for FailedAction' do
      let(:action) { FailedAction.new }

      it "return false" do
        response = action.call(params)
        expect(response).to have_http_status(404)
      end
    end

    context 'for RedirectedAction' do
      let(:action) { RedirectedAction.new }

      it "return false" do
        response = action.call(params)
        expect(response).to_not have_http_status(404)
      end
    end
  end

  describe 'with a error symbol status' do
    context 'for SuccessfulAction' do
      let(:action) { SuccessfulAction.new }

      it "return true" do
        response = action.call(params)
        expect(response).to_not have_http_status(:error)
        expect(response).to_not have_http_status(:missing)
      end
    end

    context 'for FailedAction' do
      let(:action) { FailedAction.new }

      it 'return true' do
        response = action.call(params)
        expect(response).to have_http_status(:error)
        expect(response).to have_http_status(:missing)
      end
    end

    context 'for RedirectedAction' do
      let(:action) { RedirectedAction.new }

      it "return false" do
        response = action.call(params)
        expect(response).to_not have_http_status(:error)
        expect(response).to_not have_http_status(:missing)
      end
    end
  end
end
