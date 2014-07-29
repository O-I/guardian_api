module Guardian
  module Request
    def get(path, options = {})
      request(:get, path, options)
    end

    private

    def request(method, path, options = {})
      response = connection.send(method) do |request|
        request.url(path, options.merge(auth))
      end
      response.body
    end

    def auth
      { 'api-key' => api_key }
    end
  end
end