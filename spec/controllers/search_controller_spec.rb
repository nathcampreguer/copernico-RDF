require 'spec_helper'

describe SearchController do

  describe "GET #index" do

    it "generates a list of metadata" do
      visit '/'
      url = "http://boldo.caiena.net:8080/geonetwork/srv/eng/xml.search"
      canned_request = File.read 'spec/support/fixtures/request_all_metadata.xml'
      WebMock.should have_requested(:post, url)
      .with(body: canned_request, headers: {'Content-Type' => 'application/xml'})
    end
  end

end
