class Quality
  include Tripod::Resource

  field :scope, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/dataquality#scope'
  field :statement, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/lineage#statement'
  field :maintainance, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/code/MaintenanceFrequency/'

  attr_accessor :scope, :statement, :maintainance

  def initialize(params={})
    params.each do |attr, value|
      public_send("#{attr}=", value)
    end
  end
end
