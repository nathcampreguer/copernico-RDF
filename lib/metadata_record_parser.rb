class MetadataRecordParser

  def self.parse(data)
    xml = Nokogiri::XML(data)
    xml.remove_namespaces!

    xml.xpath("//MD_Metadata").inject([]) do |acc, node|
      acc << new_metadata_record(node)
    end
  end

  private

  def self.node_text(node, selector)
    if (node.xpath(selector).inner_text != '')
      node.xpath(selector).inner_text
    else
      text = '-- Ausente --'
    end
  end

  def self.new_metadata_record(node)
    identification_path = 'identificationInfo/MD_DataIdentification'
    quality_path = 'dataQualityInfo/DQ_DataQuality'
    value = 'CharacterString'

    metadata = MetadataRecord.new({
      #Identification
      title: node_text(node, "#{identification_path}/citation/CI_Citation/title/#{value}"),
      date: node_text(node, "#{identification_path}/citation/CI_Citation/date/CI_Date/date/DateTime"),
      status: node_text(node, "#{identification_path}/status/@codeListValue"),
      credits: node_text(node, "#{identification_path}/credit/#{value}"),
      abstract: node_text(node, "#{identification_path}/abstract/#{value}"),

      #Metametadata
      uuid: node_text(node, "fileIdentifier/#{value}"),
      language: node_text(node, "language/#{value}"),
      character_set: node_text(node, 'characterSet/MD_CharacterSetCode/@codeListValue'),
      standard_name: node_text(node, "metadataStandardName/#{value}"),
      standard_version: node_text(node, "metadataStandardVersion/#{value}"),

      #Quality
      scope: node_text(node, "#{quality_path}/scope/DQ_Scope/level/MD_ScopeCode/@codeListValue"),
      statement: node_text(node, "#{quality_path}/lineage/LI_Lineage/statement/#{value}"),
      maintainance: node_text(node, "#{identification_path}/resourceMaintenance/MD_MaintenanceInformation/maintenanceAndUpdateFrequency/MD_MaintenanceFrequencyCode/@codeListValue"),

      #Contacts
      points_of_contact: new_metadata_contact(node, "#{identification_path}/pointOfContact", value),
      authors: new_metadata_contact(node, 'contact', value)
    })

    metadata.keywords = []
    node.xpath("#{identification_path}/descriptiveKeywords/MD_Keywords/keyword/#{value}").inject(metadata.keywords) do |acc, subject|
      acc << subject.inner_text
    end
    metadata
  end

  def self.new_metadata_contact(node, type, value)
    ci_contact_path = 'CI_ResponsibleParty/contactInfo/CI_Contact'
    address_path = "#{ci_contact_path}/address/CI_Address"

    contact = Contact.new({
      name: node_text(node, "#{type}[1]/CI_ResponsibleParty/individualName/#{value}"),
      organization: node_text(node, "#{type}[1]/CI_ResponsibleParty/organisationName/#{value}"),
      role: node_text(node, "#{type}[1]/CI_ResponsibleParty/positionName/#{value}"),
      address: node_text(node, "#{type}[1]/#{address_path}/deliveryPoint/#{value}"),
      city: node_text(node, "#{type}[1]/#{address_path}/city/#{value}"),
      country: node_text(node, "#{type}[1]/#{address_path}/country/#{value}"),
      zipcode: node_text(node, "#{type}[1]/#{address_path}/postalCode/#{value}"),
      phone: node_text(node, "#{type}[1]/#{ci_contact_path}/phone/CI_Telephone/voice/#{value}"),
      email: node_text(node, "#{type}[1]/#{address_path}/electronicMailAddress/#{value}")
    })
  end


end
