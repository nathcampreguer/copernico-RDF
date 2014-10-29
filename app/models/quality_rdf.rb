class QualityRdf
  include Tripod::Resource

  field :scope, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/dataquality#scope'
  field :statement, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/lineage#statement'
  field :maintainance, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/code/MaintenanceFrequency/'
end
