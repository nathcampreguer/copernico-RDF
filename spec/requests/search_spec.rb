require 'spec_helper'

describe 'Search' do

  before do
    visit root_path

    fill_in 'search_field', with: ''
    click_button 'Buscar'
  end

  let(:support_path) { 'spec/support/fixtures/' }
  let(:canned_response) { File.read "#{support_path}all_metadata_results.xml" }
  let(:index) { Wrapper::GeonetworkApi.new.get_metadata_index(canned_response) }

  it 'displays an empty search based index' do

    index.each { |metadata|
      expect(page).to have_content(metadata.title)
      expect(page).to have_content(metadata.abstract)
      metadata.keywords.each{ |keyword|
        expect(page).to have_content(keyword)
      }
    }
  end

  context 'when a user clicks on the title' do
    before do
      visit root_path

      click_link index[0].title
    end

    it 'redirects to the metadata show page' do
      expect(page).to have_content(index[0].uuid)
    end
  end

end
