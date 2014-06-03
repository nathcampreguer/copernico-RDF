module Wrapper
  class GeonetworkApi
    class << self
      attr_accessor :base_uri, :metadata, :total_records, :total_server_records,
                    :index_records
    end

    include HTTP

    # @base_uri = 'http://boldo.caiena.net:8080/geonetwork/srv/eng/'
    @base_uri = 'http://mapas.mma.gov.br/geonetwork/srv/br/'
    @metadata = MetadataRecord.new
    @total_server_records = 0
    @total_records = 0
    @index_records = []

    def get_response(builder, service)
      response = HTTP.with_headers(content_type: "application/xml")
                     .post("#{Wrapper::GeonetworkApi.base_uri}#{service}",
                      body: builder.to_xml).response.body
    end

    def get_results(search_params)
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.request {
          xml.any ''
        }
      end

      builder_for_summary = Nokogiri::XML::Builder.new do |xml|
        xml['csw']
        .GetRecords('xmlns:csw' => 'http://www.opengis.net/cat/csw/2.0.2',
                    'service' => 'CSW',
                    'version' => '2.0.2',
                    'resultType' => 'results',
                    # metadata records start at position 1
                    'startPosition' => '1',
                    'maxRecords' => "#{Wrapper::GeonetworkApi.total_server_records}"
                    ) do

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

      Wrapper::GeonetworkApi.total_server_records = get_total_server_records(get_response(builder, "xml.search"))
      Wrapper::GeonetworkApi.index_records = get_metadata_index(get_response(builder_for_summary,"csw"))
      Wrapper::GeonetworkApi.total_records = Wrapper::GeonetworkApi.index_records.size
      Wrapper::GeonetworkApi.index_records
    end

    private

    def get_total_server_records(data)
      xml = Nokogiri::XML(data)
      xml.remove_namespaces!
      total_records = xml.xpath("//summary/@count")
                         .inner_text.to_i
    end

    def get_metadata_index(data)
      xml = Nokogiri::XML(data)
      index_records = []
      xml.remove_namespaces!
      xml.xpath("//SummaryRecord").each { |node|
        Wrapper::GeonetworkApi.metadata = MetadataRecord.new
        Wrapper::GeonetworkApi.metadata.uuid = node.xpath('identifier').inner_text
        Wrapper::GeonetworkApi.metadata.title = node.xpath('title').inner_text
        Wrapper::GeonetworkApi.metadata.abstract = node.xpath('abstract').inner_text
        subjects = []

        node.xpath('subject').each { |subject|
          subjects << subject.inner_text
        }
        Wrapper::GeonetworkApi.metadata.keywords = subjects

        index_records << Wrapper::GeonetworkApi.metadata
      }

      index_records
    end
  end
end
