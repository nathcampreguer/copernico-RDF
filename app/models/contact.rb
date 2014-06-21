class Contact
  attr_accessor :name, :organization, :role
  attr_accessor :address, :city, :country, :zipcode
  attr_accessor :phone, :email

  def initialize(params={})
    params.each do |attr, value|
      public_send("#{attr}=", value)
    end
  end
end
