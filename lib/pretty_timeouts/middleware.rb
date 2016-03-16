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
        timeout = env[:request][:timeout]
        url = env[:url]
        error = ::PrettyTimeouts::TimeoutError.new("#{@service_name} timeout of #{timeout}s reached attempting to connect to #{url}")
        error.set_backtrace e.backtrace
        raise error
      end
    end
  end
end
