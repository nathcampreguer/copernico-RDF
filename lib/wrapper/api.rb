module Wrapper
  class Api
    class << self
      attr_accessor :base_uri
    end

    include HTTP

    @base_uri = 'http://boldo.caiena.net:8080/geonetwork/srv/eng/'

    def get_results(search_params)
      builder_for_summary = Nokogiri::XML::Builder.new do |xml|
        xml['csw'].GetRecords('xmlns:csw' => 'http://www.opengis.net/cat/csw/2.0.2',
                              'service' => 'CSW',
                              'version' => '2.0.2',
                              'resultType' => 'results',
                              # metadata records start at position 1
                              'startPosition' => '1',
                              'maxRecords' => '10') do
          xml['csw'].Query('typeNames' => 'gmd:MD_Metadata') {
            xml['csw'].Constraint('version' => '1.1.0') {
              xml.Filter('xmlns' => 'http://www.opengis.net/ogc',
                         'xmlns:gml' => 'http://www.opengis.net/gml') {
                xml.PropertyIsLike('wildCard' => '','singleChar' => '_') {
                  xml.PropertyName 'any'
                  xml.Literal search_params
                }
              }
            }
          }
        end
      end

      response = HTTP.with_headers(content_type: "application/xml")
                .post("#{Wrapper::Api.base_uri}csw",
                body: builder_for_summary.to_xml).response.body
    end
  end
end
