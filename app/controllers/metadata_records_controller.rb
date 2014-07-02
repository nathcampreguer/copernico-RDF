class MetadataRecordsController < ApplicationController
  PROVIDERS = {
    ana: {
      title: 'Agência Nacional de Águas',
      url: 'http://metadados.ana.gov.br/geonetwork/srv/pt',
    },

    caiena: {
      title: 'Caiena',
      url: 'http://boldo.caiena.net:8080/geonetwork/srv/eng'
    },

    mma: {
      title: 'Ministério do Meio Ambiente',
      url: 'http://mapas.mma.gov.br/geonetwork/srv/br'
    }
  }

  DEFAULT_PROVIDER = :ana

  def index
    @metadata_records = paginated(geonetwork_api.search(params[:search]))
  end

  def show
    @metadata_record = geonetwork_api.find(params[:uuid])
  end

  private

  def geonetwork_api
    GeonetworkApi.new(PROVIDERS[DEFAULT_PROVIDER][:url])
  end

  def paginated(metadata_records)
    Kaminari.paginate_array(metadata_records).page(params[:page]).per(5)
  end
end
