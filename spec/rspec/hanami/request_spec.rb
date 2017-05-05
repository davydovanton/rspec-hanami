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
  end
end
