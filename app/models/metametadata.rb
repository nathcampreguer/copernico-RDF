class Metametadata
  include Tripod::Resource

  field :uuid, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#fileIdentifier'
  field :standard_name, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#metadataStandardName'
  field :standard_version, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#metadataStandardVersion'
  field :character_sets, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/code/CharacterSet', multivalued: true
  field :languages, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#language', multivalued: true

  attr_accessor :uuid, :languages, :character_sets,
                :standard_name, :standard_version

  def initialize(params={})
    params.each do |attr, value|
      public_send("#{attr}=", value)
    end
  end
end
