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

  describe 'MatchStatus' do
    SUCCESS_STATUSES      = [200, 201, 202, 203, 204]
    ERROR_STATUSES        = [400, 401, 402, 403, 404]
    SERVER_ERROR_STATUSES = [500, 501, 502, 503, 502, 503]
    REDIRECTION_STATUSES  = [301, 302, 303, 304]

    describe 'when expecting numeric status' do
    end

    describe 'when expecting symbol status' do
      let(:service) { RSpec::Hanami::Matchers::MatchStatus.new }

      context 'for success statuses' do
        it 'match status code and symbol' do
          SUCCESS_STATUSES.each do |status|
            expect(service.(status, :success)).to be true
            expect(service.(status, :redirect)).to be false
            expect(service.(status, :missing)).to be false
            expect(service.(status, :error)).to be false
          end
        end
      end

      context 'for redirection statuses' do
        it 'match status code and symbol' do
          REDIRECTION_STATUSES.each do |status|
            expect(service.(status, :success)).to be false
            expect(service.(status, :redirect)).to be true
            expect(service.(status, :missing)).to be false
            expect(service.(status, :error)).to be false
          end
        end
      end

      context 'for error statuses' do
        it 'match status code and symbol' do
          ERROR_STATUSES.each do |status|
            expect(service.(status, :success)).to be false
            expect(service.(status, :redirect)).to be false
            expect(service.(status, :error)).to be true
          end
        end
      end

      context 'for missing status' do
        it 'match status code and symbol' do
          expect(service.(404, :success)).to be false
          expect(service.(404, :redirect)).to be false
          expect(service.(404, :missing)).to be true
          expect(service.(404, :error)).to be true
        end
      end

      context 'for server error statuses' do
        it 'match status code and symbol' do
          SERVER_ERROR_STATUSES.each do |status|
            expect(service.(status, :success)).to be false
            expect(service.(status, :redirect)).to be false
            expect(service.(status, :missing)).to be false
            expect(service.(status, :error)).to be true
          end
        end
      end
    end
  end
end
