module PrettyTimeouts
  class Middleware < ::Faraday::Middleware
    def initialize(app, service_name)
      super(app)
      @service_name = service_name
    end

    def call(env)
      begin
        @app.call(env)
      rescue Faraday::Error::TimeoutError => e
        error = ::PrettyTimeouts::TimeoutError.new(@service_name, env[:request][:timeout], env[:url])
        error.set_backtrace e.backtrace
        raise error
      end
    end
  end
end
