require 'spec_helper'

describe MetadataRecordsController do
  let(:url) { 'http://mapas.mma.gov.br/geonetwork/srv/br' }
  let(:support_path) { 'spec/support/fixtures' }
  let(:canned_request) { File.read "#{support_path}/request_all_metadata.xml" }
  let(:canned_response) { File.read "#{support_path}/all_metadata_results.xml" }
  let(:xml_search_response) { File.read "#{support_path}/xml_search_response.xml" }
  let(:providers) { { 'caiena' => { url: url, title: 'Caiena' } } }

  before(:each) do
    # stuba o provedor de servico do geonetwork
    stub_const('MetadataRecordsController::DEFAULT_PROVIDER', 'caiena')
    stub_const('MetadataRecordsController::PROVIDERS', providers)

    stub_request(:post, "#{url}/csw")
      .with(body: anything)
      .to_return(body: canned_response)

    stub_request(:post, "#{url}/xml.search")
      .with(body: anything)
      .to_return(body: xml_search_response)
  end

  describe 'GET #index' do
    before do
      get :index
    end

    it 'sends a search request to GeoNetwork to the Api' do
      WebMock.should have_requested(:post, "#{url}/csw")
    end

    it 'sends a xml.search request to GeoNetwork to the Api' do
      WebMock.should have_requested(:post, "#{url}/xml.search")
    end

    it 'receives a collection of Metadata Record as a response' do
      response = HTTP.with_headers(content_type: 'application/xml')
        .post("#{url}/csw", body: canned_request).response

      expect(response.body).to eql(canned_response)
    end
  end

  describe 'when provider is present' do
    it 'instantiates GeonetworkApi based on provider' do
      stub_request(:post, "http://other.com/csw")
      .with(body: anything)
      .to_return(body: canned_response)

      stub_request(:post, "http://other.com/xml.search")
        .with(body: anything)
        .to_return(body: xml_search_response)

      providers['other'] = { url: 'other.com' }
      stub_const('MetadataRecordsController::PROVIDERS', providers)
      GeonetworkApi.stub(:new).and_call_original
      get :index, provider: 'other'
      expect(GeonetworkApi).to have_received(:new).with(providers['other'][:url])
    end
  end
end
