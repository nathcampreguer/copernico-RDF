class Metadata
  include ActiveModel::Model

  attr_accessor :language, :character_set,
                :standart_name, :standart_version

  validates_presence_of :language, :character_set,
                        :standart_name, :standart_version
end
