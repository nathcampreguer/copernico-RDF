# -*- encoding : utf-8 -*-
class Quality
  include ActiveModel::Model

  attr_accessor :scope, :statement, :maintainance

  validates_presence_of :scope, :statement, :maintainance
end
