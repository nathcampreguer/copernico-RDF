require 'http'
require 'nokogiri'

class SearchController < ApplicationController
  def index
    url = 'http://boldo.caiena.net:8080/geonetwork/srv/eng/'

    # request & response for metadata summaries
    builder_for_summary = Nokogiri::XML::Builder.new do |xml|
      xml.request {
        xml.any params[:search_field]
      }
    end

    response = HTTP.with_headers(content_type: "application/xml")
                   .post("#{url}xml.search",
                   body: builder_for_summary.to_xml).response

    # needed variables for retrieving the full metadata
    @ids = get_metadata_id(response.body)
    @schemas = get_schema(response.body)
    @count = get_metadata_count(response.body)

    # array of resulting metada
    @metadata_info = []
    index = 0

    # request & response for full metadata
    while index < @count.to_i do
      builder_for_metadata = Nokogiri::XML::Builder.new do |xml|
        xml.request {
          xml.id @ids[index]
        }
      end

      response2 = HTTP.with_headers(content_type: "application/xml")
                     .post("#{url}xml.metadata.get",
                     body: builder_for_metadata.to_xml).response

      # gets metada info according to schema
      if @schemas[index] == "iso19139"
        @metadata_info << get_metadata_19139(response2.body)
      elsif @schemas[index] == "iso19115"
        @metadata_info << get_metadata_19115(response2.body)
      elsif
        @metadata_info << get_metadata_fgdcstd_dublincore(response2.body)
      end
      index += 1
    end
  end

  def show
    @id = params[:id]
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

    def get_metadata_19139(data)
      xml = Nokogiri::XML(data)
      keywords = []
      title =
      xml.xpath("//gmd:MD_DataIdentification/gmd:title/gco:CharacterString").text
      author = xml.xpath("//gmd:contact/gmd:CI_ResponsibleParty/gmd:individualName/gco:CharacterString").text
      date = xml.xpath("//gmd:MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:date/gmd:CI_Date/gmd:date/gco:Date").text
      xml.xpath("//gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:keyword/gco:CharacterString").each{|elem| keywords << elem.text}
      metadata = [title, author, date, keywords]
    end

    def get_metadata_19115(data)
      xml = Nokogiri::XML(data)
      keywords = []
      title = xml.xpath("//resTitle").text
      author = xml.xpath("//mdContact/rpIndName").text
      date = xml.xpath("//dataIdInfo/idCitation/resRefDate/refDate").text
      xml.xpath("//descKeys/keyword").each{|elem| keywords << elem.text}
      metadata = [title, author, date, keywords]
    end

    def get_metadata_fgdcstd_dublincore(data)
      xml = Nokogiri::XML(data)
      keywords = []
      title = xml.xpath("//title").text
      author = xml.xpath("//origin").text
      date = xml.xpath("//pubdate").text
      xml.xpath("//keywords/theme/themekey").each{|elem| keywords << elem.text}
      metadata = [title, author, date, keywords]
    end
end
