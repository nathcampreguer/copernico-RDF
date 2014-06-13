require 'spec_helper'

describe MetadataRecord do
  let(:record) { FactoryGirl.create(:metadata_record)}

  context 'language not present' do
    before{ record.language = nil }
    it{ expect(record).not_to be_valid }
  end

  context 'character_set not present' do
    before{ record.character_set = nil }
    it{ expect(record).not_to be_valid }
  end

  context 'standart_name not present' do
    before{ record.standart_name = nil }
    it{ expect(record).not_to be_valid }
  end

  context 'standart_version not present' do
    before{ record.standart_version = nil }
    it{ expect(record).not_to be_valid }
  end
end
