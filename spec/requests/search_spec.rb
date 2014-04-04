require 'spec_helper'

describe 'Search' do

  before do
      visit root_path
  end

  it 'empty search' do

    fill_in 'search_field', with: ''
    click_button 'Search'

    expect(page).to have_content('18')
    expect(page).to have_content('20')
    expect(page).to have_content('15')
    expect(page).to have_content('16')
  end
end
