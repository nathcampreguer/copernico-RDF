class Contact
  include ActiveModel::Model

  attr_accessor :name, :organization, :role
  attr_accessor :address, :city, :state, :country, :zipcode
  attr_accessor :phone, :email

  validates_presence_of :name, :organization, :role, :address,
                        :city, :state, :country, :zipcode, :phone, :email
end
