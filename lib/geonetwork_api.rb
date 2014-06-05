class GeonetworkApi
  DEFAULT_HTTP_HEADER = { content_type: 'application/xml' }
  SERVER_COUNT_XML = %q{<?xml version="1.0"?><request><any/></request>}

  attr_accessor :base_uri

  def initialize(base_uri)
    self.base_uri = base_uri
  end

  def get_results(search_params)
    builder_for_summary = Nokogiri::XML::Builder.new do |xml|
      xml['csw']
      .GetRecords('xmlns:csw' => 'http://www.opengis.net/cat/csw/2.0.2',
                  'service' => 'CSW',
                  'version' => '2.0.2',
                  'resultType' => 'results',
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

    get_metadata_index(http_post(builder_for_summary.to_xml,"csw"))
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
    data = http_post(SERVER_COUNT_XML, "xml.search")
    Nokogiri::XML(data).xpath("//summary/@count").inner_text.to_i
  end

  def http_post(body, path)
    url = "#{base_uri}/#{path}"
    http = HTTP.with_headers(DEFAULT_HTTP_HEADER).post(url, body: body)
    http.response.body
  end
end
