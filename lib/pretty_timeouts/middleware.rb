module PrettyTimeouts
  class Middleware < ::Faraday::Middleware
    def initialize(app, service_name)
      super(app)
      @service_name = service_name
    end

    def call(env)
      begin
        @app.call(env)
      rescue Faraday::Error::TimeoutError
        raise ::PrettyTimeouts::TimeoutError.new(@service_name, env[:request][:timeout], env[:url])

      rescue Faraday::Error::ConnectionFailed => e
        raise ::PrettyTimeouts::ConnectionFailed.new(@service_name, env[:request][:open_timeout], env[:url], e.message)
      end
    end
  end
end
