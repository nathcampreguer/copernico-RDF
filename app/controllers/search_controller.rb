require 'http'
require 'nokogiri'

class SearchController < ApplicationController
  def index
    builder_for_summary = Nokogiri::XML::Builder.new do |xml|
      xml.request {
        xml.any params[:search_field]
      }
    end

    url = "http://boldo.caiena.net:8080/geonetwork/srv/eng/xml.search"

    response = HTTP.with_headers(content_type: "application/xml")
                   .post(url, body: builder_for_summary.to_xml).response

    @ids = get_metadata_id(response.body)
    @schemas = get_schema(response.body)
    @count = get_metadata_count(response.body)


    @title = []
    i = 0

    while i < @count.to_i do
        builder_for_metadata = Nokogiri::XML::Builder.new do |xml|
          xml.request {
            xml.id @ids[i]
          }
        end

        url2 = "http://boldo.caiena.net:8080/geonetwork/srv/eng/xml.metadata.get"

        response2 = HTTP.with_headers(content_type: "application/xml")
                       .post(url2, body: builder_for_metadata.to_xml).response

        if @schemas[i] == "iso19139"
          @title << get_metadata_title_19139(response2.body)
        elsif @schemas[i] == "iso19115"
          @title << get_metadata_title_19115(response2.body)
        elsif
          @title << get_metadata_title_fgdcstd_dublincore(response2.body)
        end
      i += 1
    end
  end

  private

    def get_metadata_id(data)
      xml = Nokogiri::XML(data)
      ids = []
      xml.xpath("//id").each{|elem| ids << elem.text}
      ids
    end

    def get_schema(data)
      xml = Nokogiri::XML(data)
      schemas = []
      xml.xpath("//schema").each{|elem| schemas << elem.text}
      schemas
    end

    def get_metadata_count(data)
      xml = Nokogiri::XML(data)
      xml.xpath("//response/@to").text
    end

    def get_metadata_title_19139(data)
      xml = Nokogiri::XML(data)
      xml.xpath("//gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString").text
    end

    def get_metadata_title_19115(data)
      xml = Nokogiri::XML(data)
      xml.xpath("//resTitle").text
    end

    def get_metadata_title_fgdcstd_dublincore(data)
      xml = Nokogiri::XML(data)
      xml.xpath("//title").text
    end

    #iso19139
    #gmd:citation/gmd:CI_Citation/gmd:title/gco:CharacterString

    #fgdc-std / dublin-core
    #title

    #iso19115
    #resTitle
end
