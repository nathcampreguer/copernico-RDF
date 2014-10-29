class IdentificationRdf
  include Tripod::Resource

  field :title, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/citation#title'
  field :abstract, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#abstract'
  field :keywords, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#Keywords', multivalued: true
  field :status, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#status'
  field :credits, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/metadata#credit', multivalued: true
  field :dates, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/citation#date', multivalued: true
end

