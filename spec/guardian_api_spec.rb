require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Guardian do
  describe '.new' do
    it 'returns a Guardian::Client' do
      expect(Guardian.new).to be_a Guardian::Client
    end
  end

  describe '.configure' do
    it 'sets the api_key' do
      Guardian.configure do |config|
        config.api_key = '1234'
      end
      expect(Guardian.api_key).to eq '1234'
    end

    it 'allows setting the base API URL' do
      expect(Guardian.base_url).to eq 'http://beta.content.guardianapis.com/'
      Guardian.configure do |config|
        config.base_url = 'http://content.guardianapis.com/'
      end
      expect(Guardian.base_url).to eq 'http://content.guardianapis.com/'
    end
  end
end