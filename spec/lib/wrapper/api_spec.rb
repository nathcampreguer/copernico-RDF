require 'spec_helper'

describe Wrapper::Api do

  describe 'default attributes' do
    it 'should include http methods' do
      expect(Wrapper::Api).to include HTTP
    end

    it 'should have the base url set to the GeoNetwork API endpoint' do
      expect(Wrapper::Api.base_uri)
                    .to eq('http://boldo.caiena.net:8080/geonetwork/srv/eng/')
    end
  end
end
