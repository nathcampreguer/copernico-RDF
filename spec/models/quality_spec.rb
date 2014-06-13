require 'spec_helper'

describe MetadataRecord do
  let(:record) { FactoryGirl.create(:metadata_record)}

  context 'hierarchy_level not present' do
    before{ record.hierarchy_level = nil }
    it{ expect(record).not_to be_valid }
  end

  context 'declaration not present' do
    before{ record.declaration = nil }
    it{ expect(record).not_to be_valid }
  end

  context 'maintainance not present' do
    before{ record.maintainance = nil }
    it{ expect(record).not_to be_valid }
  end
end
