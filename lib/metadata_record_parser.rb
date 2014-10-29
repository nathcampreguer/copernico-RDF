# -*- encoding : utf-8 -*-
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
    if (node.xpath(selector).inner_text != '' && !node.xpath(selector).empty?)
      node.xpath(selector).inner_text
    else
      text = '-- Ausente --'
    end
  end

  def self.children_node_text(node, selector)
    if (node.xpath(selector).children.inner_text != '' && node.xpath(selector).children != nil)
      node.xpath(selector).children.inner_text
    else
      text = '-- Ausente --'
    end
  end

  def self.new_metadata_record(node)
    identification_path = 'identificationInfo/MD_DataIdentification'
    quality_path = 'dataQualityInfo/DQ_DataQuality'
    value = 'CharacterString'
    metadata = MetadataRecord.new({
      identification: new_metadata_identification(node, identification_path, value),
      metametadata: new_metadata_metametadata(node, value),
      quality: new_metadata_quality(node, quality_path, identification_path, value),
      points_of_contact: new_metadata_contact(node, "#{identification_path}/pointOfContact", value),
      authors: new_metadata_contact(node, 'contact', value)
    })
  end

  def self.new_metadata_identification(node, identification_path, value)
    identification = Identification.new({
      title: node_text(node, "#{identification_path}/citation/CI_Citation/title/#{value}"),
      status: node_text(node, "#{identification_path}/status/@codeListValue"),
      abstract: node_text(node, "#{identification_path}/abstract/#{value}")
    })
    identification.dates = node.xpath("#{identification_path}/citation/CI_Citation/date/CI_Date/date/DateTime")
      .inject([]) do |acc, date|
        acc << date.inner_text
      end
    identification.credits = node.xpath("#{identification_path}/credit/#{value}")
      .inject([]) do |acc, credit|
        if !(node.xpath("#{identification_path}/credit/#{value}").empty?)
          acc << credit.inner_text
        else
          acc << '-- Ausente --'
        end
      end
    identification.keywords = node.xpath("#{identification_path}/descriptiveKeywords/MD_Keywords/keyword/#{value}")
      .inject([]) do |acc, keyword|
        acc << keyword.inner_text
      end
    identification
  end

  def self.new_metadata_metametadata(node, value)
    metametadata = Metametadata.new({
      uuid: node_text(node, "fileIdentifier/#{value}"),
      standard_name: node_text(node, "metadataStandardName/#{value}"),
      standard_version: node_text(node, "metadataStandardVersion/#{value}")
    })
    metametadata.languages = node.xpath("language/#{value}")
      .inject([]) do |acc, language|
        acc << language.inner_text
      end
    metametadata.character_sets = node.xpath('characterSet/MD_CharacterSetCode/@codeListValue')
      .inject([]) do |acc, character_set|
        acc << character_set.inner_text
      end
    metametadata
  end

  def self.new_metadata_quality(node, quality_path, identification_path, value)
    quality = Quality.new({
      scope: node_text(node, "#{quality_path}/scope/DQ_Scope/level/MD_ScopeCode/@codeListValue"),
      statement: node_text(node, "#{quality_path}/lineage/LI_Lineage/statement/#{value}"),
      maintainance: node_text(node, "#{identification_path}/resourceMaintenance/MD_MaintenanceInformation/maintenanceAndUpdateFrequency/MD_MaintenanceFrequencyCode/@codeListValue")
    })
  end

  def self.new_metadata_contact(node, type, value)
    ci_contact_path = 'CI_ResponsibleParty/contactInfo/CI_Contact'
    address_path = "#{ci_contact_path}/address/CI_Address"
    contacts = []

    node.xpath("#{type}").each do |contact|
      new_contact = Contact.new({
        name: children_node_text(contact, "CI_ResponsibleParty/individualName/#{value}"),
        organization: children_node_text(contact, "CI_ResponsibleParty/organisationName/#{value}"),
        role: children_node_text(contact, "CI_ResponsibleParty/positionName/#{value}"),
        address: children_node_text(contact, "#{address_path}/deliveryPoint/#{value}"),
        city: children_node_text(contact, "#{address_path}/city/#{value}"),
        country: children_node_text(contact, "#{address_path}/country/#{value}"),
        zipcode: children_node_text(contact, "#{address_path}/postalCode/#{value}"),
        phone: children_node_text(contact, "#{ci_contact_path}/phone/CI_Telephone/voice/#{value}"),
        email: children_node_text(contact, "#{address_path}/electronicMailAddress/#{value}")
      })
      contacts << new_contact
    end
    contacts
  end
end
