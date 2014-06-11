class MetadataRecord
  include ActiveModel::Model

  #Identification
  attr_accessor :title, :date, :status, :credits, :abstract, :keywords

  #Point of contact
  attr_accessor :point_contact_name, :point_contact_organization, :point_contact_role
  attr_accessor :point_contact_address, :point_contact_city, :point_contact_state, :point_contact_country
  attr_accessor :point_contact_zipcode, :point_contact_phone, :point_contact_email

  #Quality
  attr_accessor :hierarchy_level, :declaration, :maintainance

  #Metadata
  attr_accessor :uuid, :language, :character_set, :standart_name, :standart_version

  #Metadata Author
  attr_accessor :author_name, :author_organization, :author_role
  attr_accessor :author_address, :author_city, :author_state, :author_country, :author_zipcode
  attr_accessor :author_phone, :author_email


  validates_presence_of :title, :date, :status, :credits, :abstract, :keywords
  validates_presence_of :point_contact_name, :point_contact_organization, :point_contact_role
  validates_presence_of :point_contact_address, :point_contact_city, :point_contact_state, :point_contact_country
  validates_presence_of :point_contact_zipcode, :point_contact_phone, :point_contact_email
  validates_presence_of :hierarchy_level, :declaration, :maintainance, :uuid, :language, :character_set
  validates_presence_of :standart_name, :standart_version, :title, :author_name
  validates_presence_of :author_organization, :author_role, :author_address, :author_city, :author_state
  validates_presence_of :author_country, :author_zipcode, :author_phone, :author_email
end
