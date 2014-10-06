require 'spec_helper'

describe Guardian::Client do
  let(:client) { guardian_test_client }

  describe '#search' do
    before { stub_get 'search', returns: 'search.json' }

    it 'returns all pieces of content' do
      expect(client.search.response.total).to eq 1690975
      expect(client.search.response.pageSize).to eq 10
      expect(client.search.response.results.map(&:sectionName).take(3))
        .to eq ['World news', 'Education', 'Business']
    end

    it 'requests /search successfully' do
      expect(client.search.response.status).to eq 'ok'
    end

    it 'returns a Hashie::Mash' do
      expect(client.search).to be_a Hashie::Mash
    end
  end

  describe '#tags' do
    before { stub_get 'tags', returns: 'tags.json' }

    it 'returns all tags' do
      expect(client.tags.response.total).to eq 44026
      expect(client.tags.response.pageSize).to eq 10
      expect(client.tags.response.results.map(&:sectionName).take(3))
        .to eq ['Aberdeen-Grampian', 'Abu Dhabi', 'Accenture partner zone']
    end

    it 'requests /tags successfully' do
      expect(client.tags.response.status).to eq 'ok'
    end

    it 'returns a Hashie::Mash' do
      expect(client.tags).to be_a Hashie::Mash
    end
  end

  describe '#sections' do
    before { stub_get 'sections', returns: 'sections.json' }

    it 'returns all sections' do
      expect(client.sections.response.total).to eq 65
      expect(client.sections.response.results.map(&:id).take(3))
        .to eq ['community', 'weather', 'higher-education-network']
    end

    it 'requests /sections successfully' do
      expect(client.sections.response.status).to eq 'ok'
    end

    it 'returns a Hashie::Mash' do
      expect(client.sections).to be_a Hashie::Mash
    end
  end

  describe '#item' do
    let(:id) { 'money/2014/sep/21/-sp-thomas-piketty-bestseller-why' }
    before { stub_get "#{id}", returns: 'item.json' }

    it 'returns all item' do
      expect(client.item(id).response.total).to eq 1
      expect(client.item(id).response.content.webTitle)
        .to eq 'Why is Thomas Piketty\'s 700-page book a bestseller?'
    end

    it 'requests /:id successfully' do
      expect(client.item(id).response.status).to eq 'ok'
    end

    it 'returns a Hashie::Mash' do
      expect(client.item(id)).to be_a Hashie::Mash
    end
  end
end