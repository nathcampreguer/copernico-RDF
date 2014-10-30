# -*- encoding : utf-8 -*-
class MetadataRecord
  include ActiveModel::Model

  #Identification
  attr_accessor :identification
  #Metametadata
  attr_accessor :metametadata
  #Quality
  attr_accessor :quality
  #Contacts
  attr_accessor :points_of_contact, :authors

  def initialize(params={})
    params.each do |attr, value|
      public_send("#{attr}=", value)
    end
  end

  def to_rdf(provider_url)
    metadata = rdf_graph(uri(provider_url))
    metadata.to_rdf
  end

  def to_json(provider_url)
    metadata = rdf_graph(uri(provider_url))
    metadata.to_json
  end

  def to_turtle(provider_url)
    metadata = rdf_graph(uri(provider_url))
    metadata.to_ttl
  end

  private

  def uri(provider_url)
    provider_url + '/metadata.show?uuid=' + metametadata.uuid
  end

  def rdf_graph(uri)
    metadata_rdf = MetadataRecordRdf.new(uri)
    #identification
    metadata_rdf.title = identification.title
    metadata_rdf.abstract = identification.abstract
    metadata_rdf.keywords = identification.keywords
    metadata_rdf.status = identification.status
    metadata_rdf.credits = identification.credits
    metadata_rdf.dates = identification.dates

    #metametadata
    metadata_rdf.uuid = metametadata.uuid
    metadata_rdf.standard_name = metametadata.standard_name
    metadata_rdf.standard_version = metametadata.standard_version
    metadata_rdf.character_sets = metametadata.character_sets
    metadata_rdf.languages = metametadata.languages

    #quality

    metadata_rdf.scope = quality.scope
    metadata_rdf.statement = quality.statement

    metadata_rdf.save!

    metadata_rdf
  end
end
