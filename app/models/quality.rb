class Quality

  attr_accessor :scope, :statement, :maintainance

  def initialize(params={})
    params.each do |attr, value|
      public_send("#{attr}=", value)
    end
  end
end
