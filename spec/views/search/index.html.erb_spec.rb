require 'spec_helper'

describe 'search/index.html.erb' do
  it 'renders a search form' do
    visit root_path

    expect(page).to have_selector('form')
    expect(page).to have_field('search_field')
    expect(page).to have_button('Buscar')
  end
end

