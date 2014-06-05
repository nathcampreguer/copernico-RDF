class GeonetworkApi
  DEFAULT_HTTP_HEADER = { content_type: 'application/xml' }

  attr_accessor :base_uri

  def initialize(base_uri)
    self.base_uri = base_uri
  end

  def get_results(search)
    body = I18n.t('geonetwork_api.xml.search') % {
      max_records: server_records_count,
      search: search
    }

    get_metadata_index(http_post(body, 'csw'))
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
    data = http_post(I18n.t('geonetwork_api.xml.count'), "xml.search")
    Nokogiri::XML(data).xpath("//summary/@count").inner_text.to_i
  end

  def http_post(body, path)
    url = "#{base_uri}/#{path}"
    http = HTTP.with_headers(DEFAULT_HTTP_HEADER).post(url, body: body)
    http.response.body
  end
end
