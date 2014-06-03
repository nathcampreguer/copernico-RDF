require 'spec_helper'

describe 'Search' do

  before do
    visit root_path

    fill_in 'search_field', with: ''
    click_button 'Buscar'
  end

  let(:support_path) { 'spec/support/fixtures/' }
  let(:canned_response){ File.read "#{support_path}all_metadata_results.xml" }

  it 'displays an empty search based index' do
    index = get_metadata_index(canned_response)

    index.each { |metadata|
      expect(page).to have_content(metadata[1])
      expect(page).to have_content(metadata[2])
      metadata[3].each{ |keyword|
        expect(page).to have_content(keyword)
      }
    }
  end

end

def get_metadata_index(data)
  xml = Nokogiri::XML(data)
  index = []
  xml.remove_namespaces!
  xml.xpath("//SummaryRecord").each { |node|
    metadata = []
    metadata << node.xpath('identifier').inner_text
    metadata << node.xpath('title').inner_text
    metadata << node.xpath('abstract').inner_text
    subjects = []
    node.xpath('subject').each { |subject|
      subjects << subject.inner_text
    }
    metadata << subjects
    index << metadata
  }
  index
end
