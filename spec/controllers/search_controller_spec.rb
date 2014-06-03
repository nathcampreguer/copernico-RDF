require 'spec_helper'

describe SearchController do

  # let(:url) { 'http://boldo.caiena.net:8080/geonetwork/srv/eng/' }
  let(:url) { 'http://mapas.mma.gov.br/geonetwork/srv/br/' }
  let(:support_path) { 'spec/support/fixtures/' }
  let(:canned_request) { File.read "#{support_path}request_all_metadata.xml" }
  let(:canned_response){ File.read "#{support_path}all_metadata_results.xml" }

  describe 'GET #index' do
    before do
      visit root_path
    end

    it 'sends a search request to GeoNetwork to the Wrapper::Api' do
      WebMock.should have_requested(:post, "#{url}csw")
    end

    it 'sends a xml.search request to GeoNetwork to the Wrapper::Api' do
      WebMock.should have_requested(:post, "#{url}xml.search")
    end

    it 'receives a collection of Metadata Record as a response' do
      response = HTTP.with_headers(content_type: 'application/xml')
                     .post("#{url}csw", body: canned_request)
                     .response
      expect(response.body).to eql(canned_response)
    end
  end
end
