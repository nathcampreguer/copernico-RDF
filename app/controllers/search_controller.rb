require 'http'
require 'nokogiri'

class SearchController < ApplicationController
  def index
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.request {
        xml.any ""
      }
    end

    url = "http://boldo.caiena.net:8080/geonetwork/srv/eng/xml.search"

    HTTP.with_headers(content_type: "application/xml")
        .post(url, body: builder.to_xml)
  end
end
