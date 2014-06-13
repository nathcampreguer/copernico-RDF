require 'spec_helper'

describe 'Search' do
  let(:support_path) { 'spec/support/fixtures/' }
  let(:index_response) { File.read "#{support_path}all_metadata_results.xml" }
  let(:metadata_records) { MetadataRecordParser.parse_index(index_response) }
  let(:show_response) { File.read "#{support_path}xml_metadata_get_result.xml" }
  #let(:metadata_record) { MetadataRecordParser.parse_show(show_response) }
  #Implementar parse_show

  before do
    # evita que seja invocado o geonetwork pois eh desnecessario nesse teste
    # e teria que ser estubado
    GeonetworkApi.any_instance.stub(:search).and_return(metadata_records)

    visit root_path

    fill_in 'search', with: ''
    click_button 'Buscar'
  end

  it 'displays an empty search based metadata_records' do
    metadata_records.each { |metadata_record|
      expect(page).to have_content(metadata_record.title)
      expect(page).to have_content(metadata_record.abstract)
      metadata_record.keywords.each{ |keyword|
        expect(page).to have_content(keyword)
      }
    }
  end

  context 'when a user clicks on the title' do
    before do
      #GeonetworkApi.any_instance.stub(:find).and_return(metadata_record)
      #implementar parse_show

      visit root_path

      click_link metadata_records[0].title
    end

    it 'redirects to the metadata show page' do
      expect(page).to have_content(metadata_records[0].uuid)
    end
  end
end
