require 'spec_helper'
require 'rspec/hanami/request_helpers'

RSpec.describe RSpec::Hanami::RequestHelpers::Request do
  describe '#env' do
    [['GET',    '/',         {}],
     ['POST',   '/users',    {}],
     ['OPTIONS', '/users',    {}],
     ['PATCH',  '/posts',    {}],
     ['PUT',    '/comments', {}],
     ['DELETE', '/tags',     {}]].each do |method, path, options|
      it "returns hash for #{path} #{method}" do
        request = RSpec::Hanami::RequestHelpers::Request.new(method, path, options).env
        expect(request["REQUEST_METHOD"]).to eq method
        expect(request["PATH_INFO"]).to eq path
        expect(request["QUERY_STRING"]).to eq "?"
      end
    end

    let(:headers) { { "Content-type": "application/json", "auth" => "whatever" } }
    let(:params) { { "whatever": "whatever" } }

    let(:options) { { headers: headers, params: params } }

    it "returns hash for options" do
      request = RSpec::Hanami::RequestHelpers::Request.new("GET", "", options).env
      expect(request["CONTENT_TYPE"]).to eq "application/json"
      expect(request["HTTP_CONTENT_TYPE"]).to be_nil
      expect(request["HTTP_AUTH"]).to eq "whatever"
      expect(request["rack.input"].string).to eq params.to_json
    end
  end
end
