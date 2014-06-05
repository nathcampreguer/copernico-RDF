class SearchController < ApplicationController
  BASE_URIS = {
    caiena: 'http://boldo.caiena.net:8080/geonetwork/srv/eng',
    mma: 'http://mapas.mma.gov.br/geonetwork/srv/br'
  }

  def index
    results = geonetwork_api.get_results(params[:search_field])
    @index = Kaminari.paginate_array(results).page(params[:page]).per(5)
  end

  def show
    @uuid = params[:uuid]
  end

  private

  def geonetwork_api
    GeonetworkApi.new(BASE_URIS[:mma])
  end
end
