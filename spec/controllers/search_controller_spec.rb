require 'spec_helper'

describe SearchController do
  let(:url) { 'http://mapas.mma.gov.br/geonetwork/srv/br' }
  let(:support_path) { 'spec/support/fixtures' }
  let(:canned_request) { File.read "#{support_path}/request_all_metadata.xml" }
  let(:canned_response) { File.read "#{support_path}/all_metadata_results.xml" }
  let(:xml_search_response) { File.read "#{support_path}/xml_search_response.xml" }

  describe 'GET #index' do
    before do
      # stuba o provedor de servico do geonetwork
      stub_const('SearchController::DEFAULT_PROVIDER', :caiena)
      stub_const('SearchController::BASE_URIS', { caiena: url })

      stub_request(:post, "#{url}/csw")
        .with(body: anything)
        .to_return(body: canned_response)

      stub_request(:post, "#{url}/xml.search")
        .with(body: anything)
        .to_return(body: xml_search_response)

      visit root_path
    end

    it 'sends a search request to GeoNetwork trought the Api' do
      WebMock.should have_requested(:post, "#{url}/csw")
    end

    it 'sends a xml.search request to GeoNetwork trought the Api' do
      WebMock.should have_requested(:post, "#{url}/xml.search")
    end

    it 'receives a collection of Metadata Record as a response' do
      response = HTTP.with_headers(content_type: 'application/xml')
        .post("#{url}/csw", body: canned_request).response

      expect(response.body).to eql(canned_response)
    end
  end

  describe 'POST #show' do
    it 'sends a search request to GeoNetwork trought the Api' do
      #Implementar
    end
  end
end
