class MetadataRecord
  include ActiveModel::Model
  include ActiveModel::Validations
  extend ActiveModel::Naming

  attr_accessor :uuid, :title, :abstract, :keywords

  validates :uuid, presence: true
  validates :title, presence: true
  validates :abstract, presence: true
  validates :keywords, presence: true
end
