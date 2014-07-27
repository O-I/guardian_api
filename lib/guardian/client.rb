require_relative 'configuration'

module Guardian
  class Client
    include Guardian::Configuration

    BASE_URL = 'http://content.guardianapis.com/'

    def initialize
      reset
    end
  end
end