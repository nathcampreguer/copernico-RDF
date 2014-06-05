class GeonetworkApi
  DEFAULT_HTTP_HEADER = { content_type: 'application/xml' }

  attr_accessor :base_uri

  def initialize(base_uri)
    self.base_uri = base_uri
  end

  def search(search)
    body = I18n.t('geonetwork_api.xml.search') % {
      max_records: server_records_count,
      search: search
    }

    MetadataRecordParser.parse(http_post(body, 'xml.search'))
  end

  private

  def server_records_count
    data = http_post(I18n.t('geonetwork_api.xml.count'), 'csw')
    Nokogiri::XML(data).xpath("//summary/@count").inner_text.to_i
  end

  def http_post(body, path)
    url = "#{base_uri}/#{path}"
    http = HTTP.with_headers(DEFAULT_HTTP_HEADER).post(url, body: body)
    http.response.body
  end
end
