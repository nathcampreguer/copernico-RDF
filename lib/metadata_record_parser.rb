class MetadataRecordParser

  def self.parse(data)
    xml = Nokogiri::XML(data)
    xml.remove_namespaces!

    xml.xpath("//SummaryRecord").inject([]) do |acc, node|
      acc << new_metadata_record(node)
    end
  end

  private

  def self.node_text(node, selector)
    node.xpath(selector).inner_text
  end

  def self.new_metadata_record(node)
    metadata = MetadataRecord.new({
      uuid: node_text(node, 'identifier'),
      title: node_text(node, 'title'),
      abstract: node_text(node, 'abstract')
    })

    metadata.keywords = []
    node.xpath('subject').inject(metadata.keywords) do |acc, subject|
      acc << subject.inner_text
    end
    metadata
  end
end
