module Guardian
  class << self
    # Alias for Guardian::Client.new
    # @return [Guardian::Client]
    def new
      @client ||= Guardian::Client.new
    end

    # Delegate to Guardian::Client
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    def respond_to?(method, include_private = false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end