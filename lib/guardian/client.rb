require_relative 'request'
require_relative 'connection'
require_relative 'configuration'

module Guardian
  class Client
    include Guardian::Request
    include Guardian::Connection
    include Guardian::Configuration

    def initialize
      reset
    end

    def search(options = {})
      get('search', options)
    end

    def tags(options = {})
      get('tags', options)
    end

    def sections(options = {})
      get('sections', options)
    end

    def item(id, options = {})
      get(id, options)
    end
  end
end