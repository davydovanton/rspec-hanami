require 'spec_helper'
require 'rspec/hanami/match_status'

RSpec.describe RSpec::Hanami::MatchStatus do
  SUCCESS_STATUSES      = [200, 201, 202, 203, 204]
  ERROR_STATUSES        = [400, 401, 402, 403, 404]
  SERVER_ERROR_STATUSES = [500, 501, 502, 503, 502, 503]
  REDIRECTION_STATUSES  = [301, 302, 303, 304]

  let(:service) { RSpec::Hanami::MatchStatus.new }

  describe 'when expecting symbol status' do
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

  describe 'when expecting rack symbol status' do
    Rack::Utils::SYMBOL_TO_STATUS_CODE.each do |status, code|
      it "returns true for #{status.inspect} status" do
        expect(service.(code, status)).to be true
      end
    end
  end
end
