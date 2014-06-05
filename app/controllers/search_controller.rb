class SearchController < ApplicationController
  BASE_URIS = {
    ana: 'http://metadados.ana.gov.br/geonetwork/srv/pt',
    caiena: 'http://boldo.caiena.net:8080/geonetwork/srv/eng',
    mma: 'http://mapas.mma.gov.br/geonetwork/srv/br'
  }

  DEFAULT_PROVIDER = :ana

  def index
    @metadata_records = paginated(geonetwork_api.search(params[:search_field]))
  end

  def show
    #XXX: implementar @metadata_record = geonetwork_api.find(params[:uuid])
    @uuid = params[:uuid]
  end

  private

  def geonetwork_api
    GeonetworkApi.new(BASE_URIS[DEFAULT_PROVIDER])
  end

  def paginated(metadata_records)
    Kaminari.paginate_array(metadata_records).page(params[:page]).per(5)
  end
end
