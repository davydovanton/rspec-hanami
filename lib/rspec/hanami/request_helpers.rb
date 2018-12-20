module RSpec
  module Hanami
    module RequestHelpers
      class Request
        def initialize(method, path, options)
          @path, @query_string = path.split('?', 2)
          @method = method
          @params = options[:params]
          @headers = options[:headers] || {}
        end

        def env
          default_env.tap do |env|
            env['PATH_INFO']      = @path
            env['REQUEST_METHOD'] = @method
            env['QUERY_STRING']   = "?#{@query_string}"
            # TODO: Doesn't work correctly
            # Need to use something like this:
            #   ::Rack::Lint::InputWrapper.new(StringIO.new(params.env['rack.input'].read))
            env['rack.input']     = StringIO.new(@params.to_json) if @params
            # also, we need to use rack-test here instead self written stuff

            @headers.each do |key, value|
              rack_name = key.to_s.upcase.tr('-', '_')
              env["HTTP_#{rack_name}"] = value
            end
            if env.key?("HTTP_CONTENT_TYPE")
              env["CONTENT_TYPE"] = env.delete("HTTP_CONTENT_TYPE")
            end
          end
        end

        def default_env
          {
            'SCRIPT_NAME' => '',
            'SERVER_NAME' => 'localhost',
            'SERVER_PORT' => '800613',
            'rack.version' => [1, 3],
            'rack.url_scheme' => 'http',
            'rack.input' => StringIO.new,
            'rack.errors' => StringIO.new,
            'rack.multithread' => false,
            'rack.multiprocess' => false,
            'rack.run_once' => false,
            'rack.hijack?' => false
          }
        end
      end

      def self.included(klass)
        klass.class_eval do
          attr_reader :response
        end
      end

      def request(request)
        @response = ::Hanami.app.call(request.env)
      end

      def get(path, options = {})
        request(Request.new('GET', path, options))
      end

      def post(path, options = {})
        request(Request.new('POST', path, options))
      end

      def patch(path, options = {})
        request(Request.new('PATCH', path, options))
      end

      def put(path, options = {})
        request(Request.new('PUT', path, options))
      end

      def delete(path, options = {})
        request(Request.new('DELETE', path, options))
      end
    end
  end
end
