# -*- encoding : utf-8 -*-
require 'spec_helper'

describe 'search/index.html.erb' do
  it 'renders a search form' do
    # evita que seja invocado o geonetwork pois eh desnecessario nesse teste
    # e teria que ser estubado
    GeonetworkApi.any_instance.stub(:search).and_return([])

    visit root_path

    expect(page).to have_selector('form')
    expect(page).to have_field('search')
    expect(page).to have_button('Buscar')
  end
end

