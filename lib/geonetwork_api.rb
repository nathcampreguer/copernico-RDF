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
      index_records << new_metadata_record(node)
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

  def node_text(node, selector)
    node.xpath(selector).inner_text
  end

  def new_metadata_record(node)
    metadata = MetadataRecord.new({
      uuid: node_text(node, 'identifier'),
      title: node_text(node, 'title'),
      abstract: node_text(node, 'abstract')
    })

    metadata.keywords = []
    node.xpath('subject').each { |subject|
      metadata.keywords << subject.inner_text
    }

    metadata
  end
end
