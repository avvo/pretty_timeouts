require "pretty_timeouts/version"
require "faraday"

module PrettyTimeouts
  TimeoutError = Class.new(Faraday::Error::TimeoutError)
end

require "pretty_timeouts/middleware"
