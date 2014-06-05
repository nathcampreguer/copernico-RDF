class GeonetworkApi
  SERVER_COUNT_XML = %q{<?xml version="1.0"?><request><any/></request>}

  attr_accessor :base_uri, :metadata, :index_records

  def initialize(base_uri)
    self.base_uri = base_uri
    @metadata = MetadataRecord.new
    @index_records = []
  end

  def get_response(body, service)
    http = HTTP.with_headers(content_type: "application/xml").post("#{base_uri}#{service}", body: body)

    http.response.body
  end

  def get_results(search_params)
    builder_for_summary = Nokogiri::XML::Builder.new do |xml|
      xml['csw']
      .GetRecords('xmlns:csw' => 'http://www.opengis.net/cat/csw/2.0.2',
                  'service' => 'CSW',
                  'version' => '2.0.2',
                  'resultType' => 'results',
                  # metadata records start at position 1
                  'startPosition' => '1',
                  'maxRecords' => "#{server_records_count}"
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

    self.index_records = get_metadata_index(get_response(builder_for_summary.to_xml,"csw"))
    index_records
  end

  def get_metadata_index(data)
    xml = Nokogiri::XML(data)
    index_records = []
    xml.remove_namespaces!
    xml.xpath("//SummaryRecord").each { |node|
      metadata = MetadataRecord.new
      metadata.uuid = node.xpath('identifier').inner_text
      metadata.title = node.xpath('title').inner_text
      metadata.abstract = node.xpath('abstract').inner_text
      subjects = []

      node.xpath('subject').each { |subject|
        subjects << subject.inner_text
      }
      metadata.keywords = subjects

      index_records << metadata
    }

    index_records
  end

  private

  def server_records_count
    return @server_records_count if @server_records_count
    data = get_response(SERVER_COUNT_XML, "xml.search")
    @server_records_count =
      Nokogiri::XML(data).xpath("//summary/@count").inner_text.to_i
  end
end
