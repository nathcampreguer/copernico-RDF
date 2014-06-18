class MetadataRecord
  include ActiveModel::Model

  #Identification
  attr_accessor :title, :date, :status, :credits, :abstract, :keywords
  #Metadata
  attr_accessor :uuid, :language, :character_set,
                :standard_name, :standard_version
  #Quality
  attr_accessor :scope, :statement, :maintainance
  #Contacts
  attr_accessor :points_of_contact, :authors

  def initialize(params={})
    params.each do |attr, value|
      public_send("#{attr}=", value)
    end
  end
end
