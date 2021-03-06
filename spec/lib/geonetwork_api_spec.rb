# -*- encoding : utf-8 -*-
require 'spec_helper'

describe GeonetworkApi do
  let(:api) { GeonetworkApi.new(url) }
  let(:url) { 'http://mapas.mma.gov.br/geonetwork/srv/br' }
  let(:support_path) { 'spec/support/fixtures' }
  let(:xml_search_request) { File.read "#{support_path}/xml_search_request.xml" }
  let(:xml_search_response){ File.read "#{support_path}/xml_search_response.xml" }

  describe 'default attributes' do
    it 'has a base_uri to geonetwork endpoint' do
      expect(api.base_uri).to eq(url)
    end
  end

  describe 'pagination' do
    it 'receives a collection of Metadata Record as a response' do
      stub_request(:post, "#{url}/xml.search").with(body: anything)
        .to_return(body: xml_search_response)

      response = HTTP.with_headers(content_type: 'application/xml')
                     .post("#{url}/xml.search", body: xml_search_request)
                     .response

      expect(response.body).to eql(xml_search_response)
    end
  end
end
