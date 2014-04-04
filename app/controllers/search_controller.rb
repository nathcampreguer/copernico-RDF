require 'http'
require 'nokogiri'

class SearchController < ApplicationController
  def index
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.request {
        xml.any params[:search_field]
      }
    end

    url = "http://boldo.caiena.net:8080/geonetwork/srv/eng/xml.search"

    response = HTTP.with_headers(content_type: "application/xml")
                   .post(url, body: builder.to_xml).response

    @ids = get_metadata_id(response.body)
  end

  private

    def get_metadata_id(data)
      xml = Nokogiri::XML(data)
      ids = []
      xml.xpath("//id").each{|elem| ids << elem.text}
      ids
    end
end
