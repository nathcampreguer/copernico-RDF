require 'net/http'
require 'nokogiri'

class GeonetworkApi
  DEFAULT_HTTP_HEADER = { 'ContentType' => 'application/xml' }

  attr_accessor :base_uri

  def initialize(base_uri)
    self.base_uri = base_uri
  end

  def search(search)
    body = I18n.t('geonetwork_api.xml.search') % {
      max_records: server_records_count,
      search: search
    }

    MetadataRecordParser.parse(http_post(body, 'csw'))
  end

  def find(uuid)
    body = I18n.t('geonetwork_api.xml.find') % {
      max_records: 1,
      uuid: uuid
    }

    MetadataRecordParser.parse(http_post(body, 'csw'))
  end

  private

  def server_records_count
    data = http_post(I18n.t('geonetwork_api.xml.count'), 'xml.search')
    Nokogiri::XML(data).xpath("//summary/@count").inner_text.to_i
  end

  def http_post(body, path)
   url = "#{base_uri}/#{path}"
   uri = URI.parse(url)
   http = Net::HTTP.new(uri.host, uri.port)
   response = http.post(uri.path, body, DEFAULT_HTTP_HEADER)
   response.body
  end
end
