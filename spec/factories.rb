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
    point_contact_name 'Diretoria de Geociências - DGC'
    point_contact_organization 'Fundação Instituto Brasileiro de
                                 Geografia e Estatística - IBGE'
    point_contact_role 'Produtor: autor do recurso'
    point_contact_address 'Av. Brasil, 15671 - Parada de Lucas'
    point_contact_city 'Rio de Janeiro'
    point_contact_state 'RJ: Rio de Janeiro'
    point_contact_country 'BR'
    point_contact_zipcode '21241-051'
    point_contact_phone '55 (21) 2142-4987'
    point_contact_email 'cartografia@ibge.gov.br'
    hierarchy_level 'Folha: informação aplicável a um subconjunto
                      de dados geográficos'
    declaration 'Este conjunto de dados foi obtido por vetorização
                 semi-automática dos arquivos matriciais georreferenciados.'
    maintainance 'Conforme Necessidade: dados atualizados
                   conforme necessário'
    language 'Portuguese'
    character_set 'UTF8: formato de transferência em código de caracteres
                    universal de comprimento variável de 8 bits,
                    baseado na norma ISO 10646'
    standart_name 'ISO 19115:2003/19139'
    standart_version '1.0'
    author_name 'Diretoria de Geociências - DGC'
    author_organization 'Fundação Instituto Brasileiro
                          de Geografia e Estatística - IBGE'
    author_role 'Autor: autor do recurso'
    author_address 'Av. Brasil, 15671 - Parada de Lucas'
    author_city 'Rio de Janeiro'
    author_state 'RJ: Rio de Janeiro'
    author_country 'BR'
    author_zipcode '21241-051'
    author_phone '55 (21) 2142-4987'
    author_email 'cartografia@ibge.gov.br'
  end
end
