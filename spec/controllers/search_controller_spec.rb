require 'spec_helper'

describe SearchController do

  describe 'GET #index' do

    let(:url) { 'http://boldo.caiena.net:8080/geonetwork/srv/eng/' }
    let(:support_path)   { 'spec/support/fixtures/' }
    let(:canned_request) { File.read "#{support_path}request_all_metadata.xml" }
    let(:single_request) { File.read "#{support_path}request_one_metadata.xml" }
    let(:canned_response){ File.read "#{support_path}all_metadata_results.xml" }
    let(:single_response){ File.read "#{support_path}one_metadata_result.xml"  }

    context 'creates a list of metadata' do

      before do
        visit root_path
      end

      it 'makes a request to GeoNetwork' do
        WebMock.should have_requested(:post, "#{url}xml.search")
                       .with(body: canned_request,
                       headers: {'Content-Type' => 'application/xml'})
      end

      it 'receives an xml as a response from GeoNetwork' do
        response = HTTP.with_headers(content_type: 'application/xml')
                       .post("#{url}xml.search", body: canned_request)
                       .response
        expect(response.body).to eql(canned_response)
      end
    end

    context 'gets the full metadata' do

      before do
        visit root_path
      end

      it 'makes a request to GeoNetwork' do
        WebMock.should have_requested(:post, "#{url}xml.metadata.get")
                       .with(body: single_request,
                       headers: {'Content-Type' => 'application/xml'})
      end

      it 'receives an xml as a response from GeoNetwork' do
        response = HTTP.with_headers(content_type: 'application/xml')
                       .post("#{url}xml.metadata.get", body: single_request)
                       .response
        expect(response.body).to eql(single_response)
      end
    end
  end

end
