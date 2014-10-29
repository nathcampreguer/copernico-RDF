# -*- encoding : utf-8 -*-
class MetadataRecord
  include ActiveModel::Model

  #Identification
  attr_accessor :identification
  #Metametadata
  attr_accessor :metametadata
  #Quality
  attr_accessor :quality
  #Contacts
  attr_accessor :points_of_contact, :authors

  def initialize(params={})
    params.each do |attr, value|
      public_send("#{attr}=", value)
    end
  end
end
