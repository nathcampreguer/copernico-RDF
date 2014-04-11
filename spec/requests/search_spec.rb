require 'spec_helper'

describe 'Search' do

  before do
      visit root_path
  end

  it 'empty search' do

    fill_in 'search_field', with: ''
    click_button 'Search'

    expect(page).to have_link('18', href='search/18')
    expect(page).to have_link('20', href='search/20')
    expect(page).to have_link('15', href='search/15')
    expect(page).to have_link('16', href='search/16')
  end

  it 'Metadata id link' do
    click_link '16'
    expect(page).to have_content('16')
  end
end
