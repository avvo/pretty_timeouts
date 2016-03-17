module PrettyTimeouts
  class TimeoutError < ::Faraday::Error::TimeoutError
    attr_reader :service_name, :timeout, :url

    def initialize(service_name, timeout, url)
      @service_name = service_name
      @timeout = timeout
      @url = url
    end

    def message
      "#{service_name} timeout of #{timeout}s reached attempting to connect to #{url}"
    end
  end
end
