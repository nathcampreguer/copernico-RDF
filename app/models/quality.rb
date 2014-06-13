class Quality
  include ActiveModel::Mode

  attr_accessor :hierarchy_level, :declaration, :maintainance

  validates_presence_of :hierarchy_level, :declaration, :maintainance
end
