require 'spec_helper'

describe MetadataRecord do
  let(:record) { FactoryGirl.create(:metadata_record)}

  context 'name not present' do
    before{ record.name = nil }
    it{ expect(record).not_to be_valid }
  end

  context 'role not present' do
    before{ record.role = nil }
    it{ expect(record).not_to be_valid }
  end

  context 'organization not present' do
    before{ record.organization = nil }
    it{ expect(record).not_to be_valid }
  end

  context 'address not present' do
    before{ record.address = nil }
    it{ expect(record).not_to be_valid }
  end

  context 'city not present' do
    before{ record.city = nil }
    it{ expect(record).not_to be_valid }
  end

  context 'state not present' do
    before{ record.state = nil }
    it{ expect(record).not_to be_valid }
  end

  context 'country not present' do
    before{ record.country = nil }
    it{ expect(record).not_to be_valid }
  end

  context 'zipcode not present' do
    before{ record.zipcode = nil }
    it{ expect(record).not_to be_valid }
  end

  context 'phone not present' do
    before{ record.phone = nil }
    it{ expect(record).not_to be_valid }
  end

  context 'email not present' do
    before{ record.email = nil }
    it{ expect(record).not_to be_valid }
  end
end
