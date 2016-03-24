module PrettyTimeouts
  class ConnectionFailed < ::Faraday::Error::ConnectionFailed
    attr_reader :service_name, :open_timeout, :url, :original_message

    def initialize(service_name, open_timeout, url, original_message)
      @service_name = service_name
      @open_timeout = open_timeout
      @url = url
      @original_message = original_message
    end

    def message
      "#{service_name} open timeout of #{open_timeout}s reached attempting to connect to #{url}. Got error: '#{original_message}'"
    end
  end
end
