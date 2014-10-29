class MetadataRecordRdf
  include Tripod::Resource

  rdf_type 'http://def.seegrid.csiro.au/static/isotc211/iso19115/2003/metadata'
  graph_uri 'http://def.seegrid.csiro.au/static/isotc211/iso19115/2003/metadata'

  field :identification, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#Identification'
  field :metametadata, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#Metadata'
  field :quality, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/dataquality#DataQuality'
  field :points_of_contact, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#pointOfContact', multivalued: true
  field :authors, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#contact', multivalued: true
end
