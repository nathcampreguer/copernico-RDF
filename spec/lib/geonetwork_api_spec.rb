require 'spec_helper'

describe GeonetworkApi do

  # let(:url) { 'http://boldo.caiena.net:8080/geonetwork/srv/eng/' }
  let(:url) { 'http://mapas.mma.gov.br/geonetwork/srv/br/' }
  let(:support_path) { 'spec/support/fixtures/' }
  let(:xml_search_request) { File.read "#{support_path}xml_search_request.xml" }
  let(:xml_search_response){ File.read "#{support_path}xml_search_response.xml" }

  describe 'default attributes' do
    it 'should include http methods' do
      expect(GeonetworkApi).to include HTTP
    end

    it 'should have the base url set to the GeoNetwork GeonetworkApi endpoint' do
      expect(GeonetworkApi.base_uri)
                    .to eq(url)
    end
  end

  describe 'a metadata record' do
    it 'should exist' do
      expect(GeonetworkApi.metadata).to be_a MetadataRecord
    end

    it 'should have the total of records returned' do
      expect(GeonetworkApi.total_records).to be_an(Integer)
    end

    it 'should have an array of the total records size' do
      expect(GeonetworkApi.index_records).to have(GeonetworkApi.total_records).itens
    end
  end

  describe 'pagination' do
    it 'should have the total records on the server' do
      expect(GeonetworkApi.total_server_records).to be_an(Integer)
    end

    it 'receives a collection of Metadata Record as a response' do
      response = HTTP.with_headers(content_type: 'application/xml')
                     .post("#{url}xml.search", body: xml_search_request)
                     .response
      expect(response.body).to eql(xml_search_response)
    end
  end
end
