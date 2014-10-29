class MetametadataRdf
  include Tripod::Resource

  field :uuid, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#fileIdentifier'
  field :standard_name, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#metadataStandardName'
  field :standard_version, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#metadataStandardVersion'
  field :character_sets, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/code/CharacterSet', multivalued: true
  field :languages, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#language', multivalued: true
end
