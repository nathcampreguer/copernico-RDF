require 'http'
require 'nokogiri'

class SearchController < ApplicationController
  def index
     url = 'http://boldo.caiena.net:8080/geonetwork/srv/eng/'
    # url = 'http://mapas.mma.gov.br/geonetwork/srv/br/'
    # url = 'http://www.metadados.geo.ibge.gov.br/geonetwork_ibge/srv/por/'
    # url = 'http://www.metadados.inde.gov.br/geonetwork/srv/por/'

    # request & response for metadata summaries
    builder_for_summary = Nokogiri::XML::Builder.new do |xml|
      xml['csw'].GetRecords('xmlns:csw' => 'http://www.opengis.net/cat/csw/2.0.2',
                            'service' => 'CSW',
                            'version' => '2.0.2',
                            'resultType' => 'results',
                            # metadata records start at position 1
                            'startPosition' => '1',
                            'maxRecords' => '10') do
        xml['csw'].Query('typeNames' => 'gmd:MD_Metadata') {
          xml['csw'].Constraint('version' => '1.1.0'){
            xml.Filter('xmlns' => 'http://www.opengis.net/ogc',
                       'xmlns:gml' => 'http://www.opengis.net/gml'){
              xml.PropertyIsLike('wildCard' => '',
                              'singleChar' => '_'){
                xml.PropertyName 'any'
                xml.Literal params[:search_field]
              }
            }
          }
        }
      end
    end

   response = HTTP.with_headers(content_type: "application/xml")
                  .post("#{url}csw",
                  body: builder_for_summary.to_xml).response

    @index = get_metadata_index(response.body)
  end

  def show
    @id = params[:id]
  end

  private
    def get_metadata_index(data)
      xml = Nokogiri::XML(data)
      index = []
      xml.remove_namespaces!
      xml.xpath("//SummaryRecord").each { |node|
      metadata = []
      metadata << "<b>UUID:</b> #{node.xpath('identifier').inner_text}"
      metadata << "<b>Title:</b> #{node.xpath('title').inner_text}"
      metadata << "<b>Abstract:</b> #{node.xpath('abstract').inner_text}"
      subjects = []
      node.xpath('subject').each { |subject|
        subjects << subject.inner_text
      }
      metadata << "<b>Keywords:</b> #{subjects.join(', ')}"
      index << metadata
      }
      index
    end
 end
