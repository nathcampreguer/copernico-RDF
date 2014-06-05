class SearchController < ApplicationController
  BASE_URIS = {
    caiena: 'http://boldo.caiena.net:8080/geonetwork/srv/eng',
    mma: 'http://mapas.mma.gov.br/geonetwork/srv/br'
  }

  def index
    @metadata_records = paginated(geonetwork_api.search(params[:search_field]))
  end

  def show
    @uuid = params[:uuid]
  end

  private

  def geonetwork_api
    GeonetworkApi.new(BASE_URIS[:mma])
  end

  def paginated(metadata_records)
    Kaminari.paginate_array(metadata_records).page(params[:page]).per(5)
  end
end
