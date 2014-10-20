require 'simplecov'
require 'coveralls'

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rspec'
require 'webmock/rspec'
require 'guardian_api'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = :expect }
end

WebMock.disable_net_connect!(allow: 'coveralls.io')

def guardian_test_client
  Guardian::Client.new.tap do |client|
    client.configure do |config|
      config.api_key = '1234'
    end
  end
end

AUTH = '?api-key=1234'

def stub_get(path, options = {})
  file = options.delete(:returns)
  endpoint = Guardian::Configuration::DEFAULT_BASE_URL + path + AUTH
  headers = Guardian::Configuration::DEFAULT_HEADERS
  stub_request(:get, endpoint)
    .with(headers: headers)
    .to_return(body: fixture(file))
end

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end