require 'spec_helper'

describe MetadataRecord do
  let(:record) { FactoryGirl.create(:metadata_record)}

  context 'uuid not present' do
    before{ record.uuid = nil }
    it{ expect(record).not_to be_valid }
  end

  context 'title not present' do
    before{ record.title = nil }
    it{ expect(record).not_to be_valid }
  end

  context 'date not present' do
    before{ record.date = nil }
    it{ expect(record).not_to be_valid }
  end

  context 'abstract not present' do
    before{ record.abstract = nil }
    it{ expect(record).not_to be_valid }
  end

  context 'status not present' do
    before{ record.status = nil }
    it{ expect(record).not_to be_valid }
  end

  context 'credits not present' do
    before{ record.credits = nil }
    it{ expect(record).not_to be_valid }
  end

  context 'keywords not present' do
    before{ record.keywords = nil }
    it{ expect(record).not_to be_valid }
  end
end
