module Guardian
  module Configuration

    VALID_CONFIGURATION_KEYS = [:api_key, :base_url, :headers]

    attr_accessor *VALID_CONFIGURATION_KEYS

    DEFAULT_API_KEY  = nil
    DEFAULT_BASE_URL = 'http://beta.content.guardianapis.com/'
    DEFAULT_HEADERS  = { user_agent: "guardian_api gem #{Guardian::Version}" }

    def configure
      yield self
    end

    def reset
      self.api_key  = DEFAULT_API_KEY
      self.base_url = DEFAULT_BASE_URL
      self.headers  = DEFAULT_HEADERS
      self
    end
  end
end