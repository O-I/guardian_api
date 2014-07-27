require 'faraday_middleware'

module Guardian
  module Connection

    BASE_API_URL = 'http://content.guardianapis.com/'

    private

    def connection
      options = {
        ssl: { verify: false },
        url: BASE_API_URL
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