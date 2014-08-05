require 'faraday_middleware'
require_relative 'version'

module Guardian
  module Connection

    HEADERS = { user_agent: "guardian_api gem #{Guardian::Version}" }

    private

    def connection
      options = {
        headers: HEADERS,
        ssl: { verify: false },
        url: base_url
      }

      Faraday.new(options) do |connection|
        connection.use Faraday::Request::UrlEncoded
        connection.use Faraday::Response::RaiseError
        connection.use Faraday::Response::Mashify
        connection.use Faraday::Response::ParseJson
        connection.adapter(Faraday.default_adapter)
      end
    end
  end
end