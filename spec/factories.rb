FactoryGirl.define do
  factory :metadata_record do
    skip_create

    uuid '6c4677cd-76b2-40d2-8745-a392ccb616ea'
    title 'CARTA TOPOGRÁFICA VETORIAL 1:50.000
            - FLORIANÓPOLIS SG-22-Z-D-V-2 MI 2909-2'
    date '1981'
    status 'Concluído: dados completados'
    credits 'Fundação Instituto Brasileiro de Geografia
              e Estatística - IBGE'
    abstract 'Esta folha é parte integrante da série Carta Topográfica
               1:50.000, uma das escalas que compõem o Sistema Cartográfico
               Nacional - SCN.'
    keywords ['Cartografia', 'FLORIANÓPOLIS / SC',
               'Carta Topográfica Vetorial']

      factory :point_of_contact, class: Contact do
        skip_create

        name 'Diretoria de Geociências - DGC'
        organization 'Fundação Instituto Brasileiro de
                      Geografia e Estatística - IBGE'
        role 'Produtor: autor do recurso'
        address 'Av. Brasil, 15671 - Parada de Lucas'
        city 'Rio de Janeiro'
        state 'RJ: Rio de Janeiro'
        country 'BR'
        zipcode '21241-051'
        phone '55 (21) 2142-4987'
        email 'cartografia@ibge.gov.br'
      end

      factory :author, class: Contact do
        skip_create

        name 'Diretoria de Geociências - DGC'
        organization 'Fundação Instituto Brasileiro
                      de Geografia e Estatística - IBGE'
        role 'Autor: autor do recurso'
        address 'Av. Brasil, 15671 - Parada de Lucas'
        city 'Rio de Janeiro'
        state 'RJ: Rio de Janeiro'
        country 'BR'
        zipcode '21241-051'
        phone '55 (21) 2142-4987'
        email 'cartografia@ibge.gov.br'
      end

      factory :metadata do
        skip_create

        language 'Portuguese'
        character_set 'UTF8: formato de transferência em código de caracteres
                        universal de comprimento variável de 8 bits,
                        baseado na norma ISO 10646'
        standart_name 'ISO 19115:2003/19139'
        standart_version '1.0'
      end

      factory :quality do
        skip_create

        hierarchy_level 'Folha: informação aplicável a um subconjunto
                          de dados geográficos'
        declaration 'Este conjunto de dados foi obtido por vetorização
                     semi-automática dos arquivos matriciais georreferenciados.'
        maintainance 'Conforme Necessidade: dados atualizados
                       conforme necessário'
      end
    end
end
