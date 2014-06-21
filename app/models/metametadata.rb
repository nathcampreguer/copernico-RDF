class Metametadata
  attr_accessor :uuid, :languages, :character_sets,
                :standard_name, :standard_version

  def initialize(params={})
    params.each do |attr, value|
      public_send("#{attr}=", value)
    end
  end
end
