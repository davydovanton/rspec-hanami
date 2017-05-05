module RSpec
  module Hanami
    module RequestHelpers
      class Request
        def initialize(method, path, opts)
          @path, @query_string = path.split('?', 2)
          @method = method
          @params = opts[:params]
          @headers = opts[:headers] || {}
        end

        def env
          default_env.tap do |env|
            env['PATH_INFO']      = @path
            env['REQUEST_METHOD'] = @method
            env['QUERY_STRING']   = "?#{@query_string}"
            env['rack.input']     = StringIO.new(@params.to_json) if @params

            @headers.each do |key, value|
              rack_name = key.upcase.tr('-', '_')
              env["HTTP_#{rack_name}"] = value
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
        puts request.env
        @response = ::Hanami.app.call(request.env)
      end

      def get(path, opts = {})
        request(Request.new('GET', path, opts))
      end

      def post(path, opts = {})
        request(Request.new('POST', path, opts))
      end

      def patch(path, opts = {})
        request(Request.new('PATCH', path, opts))
      end

      def put(path, opts = {})
        request(Request.new('PUT', path, opts))
      end


      def delete(path, opts = {})
        request(Request.new('DELETE', path, opts))
      end

      def options(path, opts = {})
        request(Request.new('OPTIONS', path, opts))
      end
    end
  end
end
