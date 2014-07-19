class MetadataRecordsController < ApplicationController
  PROVIDERS = {
    'ana' => {
      title: 'Agência Nacional de Águas',
      url: 'http://metadados.ana.gov.br/geonetwork/srv/pt',
    },

    'caiena' => {
      title: 'Caiena',
      url: 'http://boldo.caiena.net:8080/geonetwork/srv/eng'
    },

    'funai' => {
      title: 'Fundação Nacional do Índio',
      url: 'http://www.metadados.inde.gov.br/geonetwork/srv/por'
    },

    'icmbio' => {
      title: 'Instituro Chico Mendes',
      url: 'http://mapas.icmbio.gov.br/geonetwork/srv/bra'
    },

    'inde' => {
      title: 'Infraestrutura Nacional de Dados Espaciais',
      url: 'http://www.metadados.inde.gov.br/geonetwork/srv/por'
    },

    'mma' => {
      title: 'Ministério do Meio Ambiente',
      url: 'http://mapas.mma.gov.br/geonetwork/srv/br'
    },

    'sipam' => {
      title: 'Sistema de Proteção de Amazônia',
      url: 'http://geonetwork.sipam.gov.br:8080/geonetwork/srv/pt'
    }
  }

  DEFAULT_PROVIDER = 'caiena'

  def index
    @metadata_records = paginated(metadata_records)
  end

  def show
    @metadata_record = geonetwork_api.find(params[:uuid])
  end

  private

  def geonetwork_api
    GeonetworkApi.new(provider[:url])
  end

  def provider
    PROVIDERS[params[:provider]] || PROVIDERS[DEFAULT_PROVIDER]
  end

  def metadata_records
    begin
      geonetwork_api.search(params[:search])
    rescue
      []
    end
  end

  def paginated(metadata_records)
    Kaminari.paginate_array(metadata_records).page(params[:page]).per(5)
  end
end
