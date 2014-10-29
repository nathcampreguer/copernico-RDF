# -*- encoding : utf-8 -*-
class Identification

  attr_accessor :title, :dates, :status, :credits, :abstract, :keywords

  def initialize(params={})
    params.each do |attr, value|
      public_send("#{attr}=", value)
    end
  end
end

