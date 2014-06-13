class MetadataRecord
  include ActiveModel::Model

  attr_accessor :title, :date, :status, :credits, :abstract, :keywords

  validates_presence_of :title, :date, :status, :credits, :abstract, :keywords

end
