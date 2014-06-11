require 'spec_helper'

describe MetadataRecord do
  before (:all) do
    @record = MetadataRecord.new(uuid: '6c4677cd-76b2-40d2-8745-a392ccb616ea',
      title: 'CARTA TOPOGRÁFICA VETORIAL 1:50.000
              - FLORIANÓPOLIS SG-22-Z-D-V-2 MI 2909-2',
      date: '1981',
      status: 'Concluído: dados completados',
      credits: 'Fundação Instituto Brasileiro de Geografia
                e Estatística - IBGE',
      abstract: 'Esta folha é parte integrante da série Carta Topográfica
                 1:50.000, uma das escalas que compõem o Sistema Cartográfico
                 Nacional - SCN.',
      keywords: ['Cartografia', 'FLORIANÓPOLIS / SC',
                 'Carta Topográfica Vetorial'],
      point_contact_name: 'Diretoria de Geociências - DGC',
      point_contact_organization: 'Fundação Instituto Brasileiro de
                                   Geografia e Estatística - IBGE',
      point_contact_role: 'Produtor: autor do recurso',
      point_contact_address: 'Av. Brasil, 15671 - Parada de Lucas',
      point_contact_city: 'Rio de Janeiro',
      point_contact_state: 'RJ: Rio de Janeiro',
      point_contact_country: 'BR',
      point_contact_zipcode: '21241-051',
      point_contact_phone: '55 (21) 2142-4987',
      point_contact_email: 'cartografia@ibge.gov.br',
      hierarchy_level: 'Folha: informação aplicável a um subconjunto
                        de dados geográficos',
      declaration: 'Este conjunto de dados foi obtido por vetorização
                   semi-automática dos arquivos matriciais georreferenciados.',
      maintainance: 'Conforme Necessidade: dados atualizados
                     conforme necessário',
      uuid: '521b15e7-f52c-4228-9699-03c70ac9d78c',
      language: 'Portuguese',
      character_set: 'UTF8: formato de transferência em código de caracteres
                      universal de comprimento variável de 8 bits,
                      baseado na norma ISO 10646',
      standart_name: 'ISO 19115:2003/19139',
      standart_version: '1.0',
      author_name: 'Diretoria de Geociências - DGC',
      author_organization: 'Fundação Instituto Brasileiro
                            de Geografia e Estatística - IBGE',
      author_role: 'Autor: autor do recurso',
      author_address: 'Av. Brasil, 15671 - Parada de Lucas',
      author_city: 'Rio de Janeiro',
      author_state: 'RJ: Rio de Janeiro',
      author_country: 'BR',
      author_zipcode: '21241-051',
      author_phone: '55 (21) 2142-4987',
      author_email: 'cartografia@ibge.gov.br')
  end

  describe 'attributes' do

    context 'Identification' do

      context 'title not present' do
        before{ @record.title = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'date not present' do
        before{ @record.date = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'abstract not present' do
        before{ @record.abstract = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'status not present' do
        before{ @record.status = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'credits not present' do
        before{ @record.credits = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'keywords not present' do
        before{ @record.keywords = nil }
        it{ expect(@record).not_to be_valid }
      end
    end

    context 'Point of contact' do
      context 'point_contact_name not present' do
        before{ @record.point_contact_name = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'point_contact_role not present' do
        before{ @record.point_contact_role = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'point_contact_organization not present' do
        before{ @record.point_contact_organization = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'point_contact_address not present' do
        before{ @record.point_contact_address = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'point_contact_city not present' do
        before{ @record.point_contact_city = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'point_contact_state not present' do
        before{ @record.point_contact_state = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'point_contact_country not present' do
        before{ @record.point_contact_country = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'point_contact_zipcode not present' do
        before{ @record.point_contact_zipcode = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'point_contact_phone not present' do
        before{ @record.point_contact_phone = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'point_contact_email not present' do
        before{ @record.point_contact_email = nil }
        it{ expect(@record).not_to be_valid }
      end
    end

    context 'Quality' do
      context 'hierarchy_level not present' do
        before{ @record.hierarchy_level = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'declaration not present' do
        before{ @record.declaration = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'maintainance not present' do
        before{ @record.maintainance = nil }
        it{ expect(@record).not_to be_valid }
      end
    end

    context 'Metadata' do
      context 'uuid not present' do
        before{ @record.uuid = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'language not present' do
        before{ @record.language = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'character_set not present' do
        before{ @record.character_set = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'standart_name not present' do
        before{ @record.standart_name = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'standart_version not present' do
        before{ @record.standart_version = nil }
        it{ expect(@record).not_to be_valid }
      end
    end

    context 'Metadata author' do
      context 'author_name not present' do
        before{ @record.author_name = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'author_organization not present' do
        before{ @record.author_organization = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'author_role not present' do
        before{ @record.author_role = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'author_address not present' do
        before{ @record.author_address = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'author_city not present' do
        before{ @record.author_city = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'author_state not present' do
        before{ @record.author_state = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'author_country not present' do
        before{ @record.author_country = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'author_name not present' do
        before{ @record.author_name = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'author_zipcode not present' do
        before{ @record.author_zipcode = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'author_phone not present' do
        before{ @record.author_phone = nil }
        it{ expect(@record).not_to be_valid }
      end

      context 'author_email not present' do
        before{ @record.author_email = nil }
        it{ expect(@record).not_to be_valid }
      end
    end
  end
end
