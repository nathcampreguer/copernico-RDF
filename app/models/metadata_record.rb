class MetadataRecord
  include ActiveModel::Model
  include Tripod::Resource

  rdf_type 'http://def.seegrid.csiro.au/static/isotc211/iso19115/2003/metadata'

  field :identification, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#Identification'
  field :metametadata, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#Metadata'
  field :quality, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/dataquality#DataQuality'
  field :points_of_contact, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#pointOfContact', multivalued: true
  field :authors, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#contact', multivalued: true

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
end
