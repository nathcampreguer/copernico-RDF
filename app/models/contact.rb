class Contact
  include Tripod::Resource

  field :name, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/citation#individualName'
  field :organization, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/citation#organisationName'
  field :role, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/citation#positionName'
  field :address, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/citation#deliveryPoint'
  field :city, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/citation#city'
  field :country, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/citation#country'
  field :zipcode, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/citation#postalCode'
  field :phone, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/citation#phone'
  field :email, 'http://def.seegrid.csiro.au/isotc211/iso19115/2003/citation#electronicMailAddress'

  attr_accessor :name, :organization, :role
  attr_accessor :address, :city, :country, :zipcode
  attr_accessor :phone, :email

  def initialize(params={})
    params.each do |attr, value|
      public_send("#{attr}=", value)
    end
  end
end
