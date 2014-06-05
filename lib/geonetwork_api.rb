class GeonetworkApi
  attr_accessor :base_uri, :metadata, :total_records, :index_records

  def initialize(base_uri)
    self.base_uri = base_uri
    @metadata = MetadataRecord.new
    @total_records = 0
    @index_records = []
  end

  def get_response(builder, service)
    http = HTTP.with_headers(content_type: "application/xml").post("#{base_uri}#{service}", body: builder.to_xml)

    http.response.body
  end

  def get_results(search_params)
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.request {
        xml.any ''
      }
    end

    total_server_records = get_total_server_records(get_response(builder, "xml.search"))

    builder_for_summary = Nokogiri::XML::Builder.new do |xml|
      xml['csw']
      .GetRecords('xmlns:csw' => 'http://www.opengis.net/cat/csw/2.0.2',
                  'service' => 'CSW',
                  'version' => '2.0.2',
                  'resultType' => 'results',
                  # metadata records start at position 1
                  'startPosition' => '1',
                  'maxRecords' => "#{total_server_records}"
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

    self.index_records = get_metadata_index(get_response(builder_for_summary,"csw"))
    self.total_records = index_records.size
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

  def get_total_server_records(data)
    xml = Nokogiri::XML(data)
    xml.remove_namespaces!
    self.total_records = xml.xpath("//summary/@count")
                       .inner_text.to_i
  end
end
