require 'spec_helper'

describe SearchController do

  let(:url) { 'http://boldo.caiena.net:8080/geonetwork/srv/eng/' }
  let(:support_path) { 'spec/support/fixtures/' }

  let(:canned_request) { File.read "#{support_path}request_all_metadata.xml" }

  let(:canned_response){ File.read "#{support_path}all_metadata_results.xml" }

  describe 'GET #index' do

    context 'creates a list of metadata summaries' do
      before do
        visit root_path
      end

      it 'makes a request to GeoNetwork' do
        WebMock.should have_requested(:post, "#{url}xml.search")
                       .with(body: canned_request,
                       headers: { 'Content-Type' => 'application/xml' } )
      end

      it 'receives an xml as a response from GeoNetwork' do
        response = HTTP.with_headers(content_type: 'application/xml')
                       .post("#{url}xml.search", body: canned_request)
                       .response
        expect(response.body).to eql(canned_response)
      end
    end

    context 'gets the full metadata by id' do
      before do
        visit root_path
      end

      it "makes a request to GeoNetwork using the correct id" do
        XML_MAP.each do |xml_request, xml_response|
          WebMock.should have_requested(:post, "#{url}xml.metadata.get")
                       .with(body: xml_request,
                       headers: { 'Content-Type' => 'application/xml' } )

          response = HTTP.with_headers(content_type: 'application/xml')
                       .post("#{url}xml.metadata.get", body: xml_request)
                       .response

          expect(response.body).to eq(xml_response)
        end
      end
    end
  end

end
